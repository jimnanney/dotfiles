-- Original from https://github.com/jordelver/cmp-jira/blob/main/lua/cmp_jira/source.lua
local Job = require('plenary.job')

local cmp_jira = {}

local registered = false

cmp_jira.setup = function()
  local source = {}

  if registered then
    return
  end

  registered = true

  local has_cmp, cmp = pcall(require, 'cmp')

  if not has_cmp then
    return
  end

  source.new = function()
    return setmetatable({ cache = {} }, { __index = source })
  end

  source.get_debug_name = function()
    return 'cmp_jira'
  end

  source.is_available = function()
    return vim.bo.filetype == 'gitcommit'
  end

  source.get_trigger_characters= function()
    return { '#' }
  end

  source.get_keyword_pattern = function()
    return string.format("[%s]\\S*", "#")
  end

  source.complete = function(self, _, callback)
    local bufnr = vim.api.nvim_get_current_buf()

    if not self.cache[bufnr] then
      Job
        :new({
          command = 'curl',
          args = {
            '-G',
            '-H',
            'Authorization: Bearer ' .. os.getenv('JIRA_TOKEN'),
            '--data-urlencode',
            'fields=summary,description,status',
            '--data-urlencode',
            -- 'jql=("assignee" = "' .. os.getenv('JIRA_USERNAME') ..
            --   '" OR "Secondary Assignee" = "' .. os.getenv('JIRA_USERNAME') ..
            --  '") AND status not in ("Discarded", "Done", "Ready for Release")',
            'jql=' ..
            'Domain = "' .. os.getenv('JIRA_DOMAIN') .. '" AND ' ..
            'status not in ("Done", "Discarded", "Ready for Release", "Released", "Backlog", "Accepted", "Blocked")',
            '--data-urlencode',
            'maxResults=1000',
            os.getenv('JIRA_API_HOST') .. '/jira/rest/api/2/search',
          },
          env = vim.env,
          on_exit = vim.schedule_wrap(function(job)
            local items = {}
            local result = job:result()
            local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))
            if not ok or parsed == nil then
              vim.notify("Failed to retrieve from jira")
              return
            end
            -- vim.notify(vim.inspect(parsed))
            for _, jira_ticket in ipairs(parsed.issues) do
              local description = jira_ticket.fields.description or ""
              if type(description) == 'string' then
                description = string.gsub(description, "\r", "")
                table.insert(items, {
                  label = string.format("#%s", jira_ticket.key),
                  insertText = string.format("%s [%s]\n\n%s\n\n", jira_ticket.fields.summary, jira_ticket.key, description),
                  documentation = {
                    kind = 'markdown',
                    value = string.format("# [%s] %s\n\n%s", jira_ticket.key, jira_ticket.fields.summary, description)
                    }
                  })
              end
              callback({ items = items, isIncomplete = false })
              self.cache[bufnr] = items
            end
          end)
        })
        :start()
    else
      return callback({ items = self.cache[bufnr], isIncomplete = false})
    end
  end

  cmp.register_source('cmp_jira', source.new())
end

return cmp_jira
