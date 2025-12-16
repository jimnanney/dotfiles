local ls = require("luasnip")
local s = ls.s
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
-- local l = extras.lambda
local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key

local underscored_node = function(position, node)
  node = node or 1
  return d(position, function(args)
    return sn(nil, { i(1, string.gsub(args[1][1], " ", "_"):lower()) } )
  end, { node })
end

local snippets = {}
local autosnippets = {}

table.insert(snippets,
  s("admt", fmt([[
require 'rails_helper'

describe 'ActiveAdmin {}' do
  let(:admin) {{ create(:user, :admin) }}
  let!(:{}) {{ create(:{}) }}

  before do
    sign_in(admin)
  end

  describe 'index' do
    it 'returns ok status code' do
      get admin_{}s_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'show' do
    it 'returns ok status code' do
      get admin_{}_path({})
      expect(response).to have_http_status(:ok)
    end
  end
end{}
]], {
  i(1, "Default Class"),
  underscored_node(2),
  underscored_node(3),
  underscored_node(4),
  underscored_node(5),
  underscored_node(6, 2),
  i(0),
  }))
)

return snippets, autosnippets

