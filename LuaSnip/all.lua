local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local context = require "snippets.context"
local username = vim.env.USER:gsub("^%l", string.upper)
return {
  s("date", f(function() return os.date "%Y-%m-%d" end)),
  s("time", p(os.date, "%T")),
  s("choicenode", c(1, { t "choice 1", t "choice 2", t "choice 3" })),
}
