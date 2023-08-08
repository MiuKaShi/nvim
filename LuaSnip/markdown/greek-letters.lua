local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local markdown = require "snippets.markdown"

return {
  s({ trig = "alp", snippetType = "autosnippet", wordTrig = false }, {
    t "\\alpha",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Alp", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Alpha",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "beta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\beta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Beta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Beta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "gam", snippetType = "autosnippet", wordTrig = false }, {
    t "\\gamma",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Gam", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Gamma",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "del", snippetType = "autosnippet", wordTrig = false }, {
    t "\\delta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Del", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Delta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "eps", snippetType = "autosnippet", wordTrig = false }, {
    t "\\epsilon",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "vps", snippetType = "autosnippet", wordTrig = false }, {
    t "\\varepsilon",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Eps", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Epsilon",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "zeta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\zeta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Zeta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Zeta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "eta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\eta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Eta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Eta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "the", snippetType = "autosnippet", wordTrig = false }, {
    t "\\theta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "The", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Theta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "iot", snippetType = "autosnippet", wordTrig = false }, {
    t "\\iota",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Iot", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Iota",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "kap", snippetType = "autosnippet", wordTrig = false }, {
    t "\\kappa",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Kap", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Kappa",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "lam", snippetType = "autosnippet", wordTrig = false }, {
    t "\\lambda",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Lam", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Lambda",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "mu", snippetType = "autosnippet", wordTrig = false }, {
    t "\\mu",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Mu", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Mu",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "nu", snippetType = "autosnippet", wordTrig = false }, {
    t "\\nu",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Nu", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Nu",
  }, { condition = markdown.in_mathzone }),
  -- s({ trig = "xi", snippetType = "autosnippet", wordTrig = false }, {
  --   t("\\xi"),
  -- }, { condition = markdown.in_mathzone }),
  -- s({ trig = "Xi", snippetType = "autosnippet", wordTrig = false }, {
  --   t("\\Xi"),
  -- }, { condition = markdown.in_mathzone }),
  s({ trig = "omi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\omicron",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "pi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\pi",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "\\pii", snippetType = "autosnippet", wordTrig = false, priority = 2000 }, {
    t "p_i",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Pi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Pi",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "rho", snippetType = "autosnippet", wordTrig = false }, {
    t "\\rho",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Rho", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Rho",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "sig", snippetType = "autosnippet", wordTrig = false }, {
    t "\\sigma",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Sig", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Sigma",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "tau", snippetType = "autosnippet", wordTrig = false }, {
    t "\\tau",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Tau", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Tau",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "ups", snippetType = "autosnippet", wordTrig = false }, {
    t "\\ups",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Ups", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Ups",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "phi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\phi",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Phi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Phi",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "vhi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\varphi",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Vhi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Varphi",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "chi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\chi",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Chi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Chi",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "psi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\psi",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Psi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Psi",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "ome", snippetType = "autosnippet", wordTrig = false }, {
    t "\\omega",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Ome", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Omega",
  }, { condition = markdown.in_mathzone }),
}
