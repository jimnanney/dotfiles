local str = require('plenary.strings')
local M = {}

local function find_assignment_node(node)
  if node == nil then
    return nil
  end
  local type = node:type()
  if type == "assignment" then
    return node
  end
  return find_assignment_node(node:parent())
end

local function starts_with(str, prefix)
  return string.sub(str, 1, string.len(prefix)) == prefix
end

local function enclosing_context(node, bufnr)
  if node == nil then
    return node
  end
  local parent = node:parent()
  if parent and parent:type() == 'call' then
    local node_text = vim.treesitter.get_node_text(parent, bufnr)
    if starts_with(node_text, 'describe') or starts_with(node_text, 'context') then
      return node
    end
  end
  return enclosing_context(parent, bufnr)
end

local function let_definition(captures, indent_to_col)
  local lines = {}
  local left_pad = string.format("%-" .. (indent_to_col) .. "s", "")
  local start_col = captures["variable"]["range"]["col1"]
  if captures["body"]["multiline"] then
    lines[#lines+1] = left_pad .. "let(:" .. captures["variable"]["text"] .. ") do"
    for line in string.gmatch(captures["body"]["text"], "[^\n]+") do
      if string.sub(line, 1, 1) == " " then
        lines[#lines+1] = left_pad .. string.sub(line, start_col - 1)
      else
       lines[#lines+1] = left_pad .. "  " .. line
      end
    end
    lines[#lines+1]  = left_pad .. "end"
  else
    lines[#lines+1] = left_pad .. "let(:" .. captures["variable"]["text"] .. ") { " .. captures["body"]["text"] .. " }"
  end
  return lines
end

local function assignment_query()
  return vim.treesitter.query.parse('ruby', [[
    (((assignment left: (identifier) @variable right: (_) @body)) @assignment)
  ]])
end

local function array_reverse(x)
  local n, m = #x, #x/2
  for i=1, m do
    x[i], x[n-i+1] = x[n-i+1], x[i]
  end
  return x
end

local function get_node_data(query_root, query, bufnr)
  local captures = {}
  for id, node, metadata in query:iter_captures(query_root, bufnr) do
    local name = query.captures[id]
    local type = node:type()
    local row1, col1, row2, col2 = node:range()
    local text = vim.treesitter.get_node_text(node, bufnr, metadata[id])
    local node_data = {
      name = name,
      type = type,
      text = text,
      node = node,
      range = { row1 = row1, col1 = col1, row2 = row2, col2 = col2 },
      multiline = row2 > row1
    }
    captures[name] = node_data
  end
  return captures
end

local function remove_lines(query_root, query, bufnr, var)
  local lines = {}
  local sexpr = var:sexpr()
  for id, node in query:iter_captures(query_root, bufnr) do
    local name = query.captures[id]
    if name == "assignment" and node:sexpr() == sexpr then
      local row1, _, row2, _ = node:range()
      lines[#lines+1] = { row1 = row1, row2 = row2 }
    end
  end
  local reversed = array_reverse(lines)
  for _, line in ipairs(reversed) do
    vim.api.nvim_buf_set_lines(bufnr, line["row1"], line["row2"] + 1, false, {})
  end
end

M.promote_to_let = function ()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor_node = vim.treesitter.get_node() -- or find the first node on the line if not in an assignment_node
  local assignment_node = find_assignment_node(cursor_node)
  if assignment_node == nil then
    return
  end
  local context = enclosing_context(assignment_node, bufnr)
  if context == nil then
    return
  end
  local start, start_col, _ = context:child(1):child(0):start()
  local captures = get_node_data(assignment_node, assignment_query(), bufnr)
  local lines = let_definition(captures, start_col)
  vim.api.nvim_buf_set_lines(bufnr, start, start, false, lines)
  remove_lines(context, assignment_query(), bufnr, assignment_node)
end

M.extract_method = function()
end

M.extract_class = function()
end
return M
