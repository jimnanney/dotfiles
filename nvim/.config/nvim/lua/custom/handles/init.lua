local handles = {}

local registered = false

handles.setup = function()
  if registered then
    return
  end
  registered = true

  local has_cmp, cmp = pcall(require, 'cmp')
  if not has_cmp then
    return
  end

  local function parse_pairs_data(pairs_file)
    local data = {}
    for _, line in pairs(pairs_file) do
      local name, email = line:match(".*: (.*); (.*)")
      if name and email then
        data[email] = name
      end
    end

    return data
  end

  local success, handles_with_names_and_emails = pcall(function()
    local pairs_file = './.pairs'
    if vim.fn.filereadable(pairs_file) == 0 then
      error(pairs_file .. ' not readable')
    end
    local pairs_data = vim.fn.readfile(pairs_file)
    return parse_pairs_data(pairs_data)
  end)

  if not success then
    return
  end

  local source = {}

  source.new = function()
    return setmetatable({}, { __index = source })
  end

  source.get_trigger_characters = function()
    return { '@' }
  end

  source.get_keyword_pattern = function()
    -- Add dot to existing keyword characters (\k).
    return [[\%(\k\|\.\)\+]]
  end

  source.complete = function(self, request, callback)
    local input = string.sub(request.context.cursor_before_line, request.offset - 1)
    local prefix = string.sub(request.context.cursor_before_line, 1, request.offset - 1)

    if vim.startswith(input, '@') and (prefix == '@' or vim.endswith(prefix, ' @')) then
      local items = {}
      for email, name in pairs(handles_with_names_and_emails) do
        table.insert(items, {
          filterText = '@' .. name .. ' ' .. email,
          label = name,
          textEdit = {
            newText = "Co-authored-by: " .. name .. " <" .. email .. "@uscis.dhs.gov" .. ">",
            range = {
              start = {
                line = request.context.cursor.row - 1,
                character = request.context.cursor.col - 1 - #input,
              },
              ['end'] = {
                line = request.context.cursor.row - 1,
                character = request.context.cursor.col - 1,
              },
            },
          },
        })
      end
      callback({
        items = items,
        isIncomplete = true,
      })
    else
      callback({ isIncomplete = true })
    end
  end

  cmp.register_source('handles', source.new())

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'calc' },
      { name = 'emoji' },
      { name = 'path' },

      -- My custom sources.
      { name = 'cmp_jira', keyword_length = 1 },
      { name = 'handles' }, -- pairs
    }),
  })
end

return handles

