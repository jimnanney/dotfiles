local Job = require('plenary.job')

local source = {}

source.new = function()
  -- local self = setmetatable({ cache = {} }, { __index = source })
  -- return self
end

source.get_debug_name = function()
  return 'cmp-jira'
end

source.complete = function (_, callback)
  -- local bufnr = vim.api.nvim_get_current_buf()
  local cmd = 'curl -H ' ..
        'Authorization: Bearer ' .. os.getenv('JIRA_TOKEN') ..
        'https://maestro-api.dhs.gov/jira/rest/api/v2/search?fields=summary,description&jql=' ..
          '%28%22Assigned%20To%3A%22%20%3D%20%22james.a.nanney%40uscis.dhs.gov%22%20OR%20%22Secondary%20Assignee%22%20%3D%20%22james.a.nanney%40uscis.dhs.gov%22%29%20AND%20status%20not%20in%20%28%22Discarded%22%2C%20%22Done%22%2C%20%22Ready%20for%20Release%22%29'
  local handle = assert(io.popen(cmd, "r"))
  local output = assert(handle:read('*a'))
        local ok, parsed = pcall(vim.json.decode, table.concat(output, ""))
        if not ok or parsed == nil then
          vim.notify("Failed to fetch jira tickets")
          return
        end

        local items = {}
        for _, jira_ticket in ipairs(parsed.issues) do
          jira_ticket.fields.description = string.gsub(jira_ticket.fields.description or "", "\r", "")
          table.insert(items, {
            label = string.format("#%s", jira_ticket.key),
            documentation = {
              kind = 'markdown',
              value = string.format("# %s\n\n%s", jira_ticket.fields.summary, jira_ticket.fields.description)
            }
          })
          callback({ items = items, isIncomplete = false })

  --if not self.cache[bufnr] then
    Job
      :new({
      command = 'curl',
      args = {
        '-H',
        'Authorization: Bearer ' .. os.getenv('JIRA_TOKEN'),
        'https://maestro-api.dhs.gov/jira/rest/api/v2/search?fields=summary,description&jql=' ..
          '%28%22Assigned%20To%3A%22%20%3D%20%22james.a.nanney%40uscis.dhs.gov%22%20OR%20%22Secondary%20Assignee%22%20%3D%20%22james.a.nanney%40uscis.dhs.gov%22%29%20AND%20status%20not%20in%20%28%22Discarded%22%2C%20%22Done%22%2C%20%22Ready%20for%20Release%22%29',
      },
      on_exit = function()
          -- self.cache[bufnr] = items
      end
    })
    :start()
  end
  -- else
  --  return callback({ items = self.cache[bufnr], isIncomplete = false})
  -- end
end

source.get_trigger_characters= function()
  return { '#' }
end

source.is_available = function()
--   return vim.bo.filetype == 'gitcommit'
  return true
end

require('cmp').register_source('cmp_jira', source)
--return source:new()
