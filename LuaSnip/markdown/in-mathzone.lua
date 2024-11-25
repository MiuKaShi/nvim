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

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

return {
  ---greek-letters
  s({ trig = "alpha", snippetType = "autosnippet", wordTrig = false }, {
    t "\\alpha",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Alpha", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Alpha",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "beta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\beta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Beta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Beta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "gamma", snippetType = "autosnippet", wordTrig = false }, {
    t "\\gamma",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Gamma", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Gamma",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "delta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\delta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Delta", snippetType = "autosnippet", wordTrig = false }, {
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
  s({ trig = "theta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\theta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Theta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Theta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "eta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\eta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Eta", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Eta",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "iota", snippetType = "autosnippet", wordTrig = false }, {
    t "\\iota",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Iota", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Iota",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "kappa", snippetType = "autosnippet", wordTrig = false }, {
    t "\\kappa",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Kap", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Kappa",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "lambda", snippetType = "autosnippet", wordTrig = false }, {
    t "\\lambda",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Lambda", snippetType = "autosnippet", wordTrig = false }, {
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
  --   t("\\xi "),
  -- }, { condition = markdown.in_mathzone }),
  -- s({ trig = "Xi", snippetType = "autosnippet", wordTrig = false }, {
  --   t("\\Xi "),
  -- }, { condition = markdown.in_mathzone }),
  s({ trig = "omi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\omicron",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "pi", snippetType = "autosnippet", wordTrig = false }, {
    t "\\pi",
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
  s({ trig = "Sigma", snippetType = "autosnippet", wordTrig = false }, {
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
  s({ trig = "omega", snippetType = "autosnippet", wordTrig = false }, {
    t "\\omega",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "Omega", snippetType = "autosnippet", wordTrig = false }, {
    t "\\Omega",
  }, { condition = markdown.in_mathzone }),
  ---math-functions
  s(
    { trig = "mll", name = "Align Math", snippetType = "autosnippet" },
    fmta(
      [[
            \begin{aligned}
                <>
            \end{aligned}
            ]],
      {
        i(0),
      }
    ),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "mcc", name = "Cases Math", snippetType = "autosnippet" },
    fmta(
      [[
            \begin{cases}
                <>
            \end{cases}
            ]],
      {
        i(0),
      }
    ),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "maa", name = "Array Math", snippetType = "autosnippet" },
    fmta(
      [[
            \begin{array}{lcl}
                <>
            \end{array}
            ]],
      {
        i(0),
      }
    ),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "ff", name = "Fraction", snippetType = "autosnippet" },
    fmta("\\frac{<>}{<>}", {
      d(1, get_visual),
      i(2),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "inti", name = "Indefinite Integral", snippetType = "autosnippet" },
    fmta("\\int <> \\,\\mathrm d<>", {
      d(1, get_visual),
      i(2, "x"),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "intd", name = "Definite Integral", snippetType = "autosnippet" },
    fmta("\\int_{<>}^{<>} <> \\,\\mathrm d<>", {
      i(1),
      i(2),
      d(3, get_visual),
      i(4, "x"),
    }),
    { condition = markdown.in_mathzone }
  ),
  -- PREABMLE
  s(
    { trig = "mbs", name = "Multiply Both Sides by", snippetType = "autosnippet" },
    fmta("\\quad \\biggr| \\times <>", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "box", name = "Boxed", snippetType = "autosnippet" },
    fmta("\\boxed{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "ln", name = "Natural Logarithm", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\ln{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "lim", name = "Limit", snippetType = "autosnippet" },
    fmta("\\lim_{<> \\to <>} <>", {
      i(1, "x"),
      i(2),
      d(3, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "aimp", name = "Annotated Implies", snippetType = "autosnippet" },
    fmta("\\xRightarrow[<>]{<>}", {
      i(1),
      d(2, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "tt", name = "Text", snippetType = "autosnippet" },
    fmta("\\text{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "aeq", name = "Annotated Equals Sign", snippetType = "autosnippet" },
    fmta("\\overset{<>}{=}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "inset", name = "In Set", snippetType = "autosnippet" },
    fmta("\\in \\mathbb{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "~", name = "Tilde", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\tilde <>", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "hat", name = "Hat", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\hat <>", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "tg", name = "Tag", snippetType = "autosnippet" },
    fmta("\\tag{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "cnl", name = "Cancel", snippetType = "autosnippet" },
    fmta("\\cancel{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "sin", name = "sin", snippetType = "autosnippet" },
    fmta("\\sin{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "cos", name = "cos", snippetType = "autosnippet" },
    fmta("\\cos{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "tan", name = "tan", snippetType = "autosnippet" },
    fmta("\\tan{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "csc", name = "cosec", snippetType = "autosnippet" },
    fmta("\\csc{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "sec", name = "sec", snippetType = "autosnippet" },
    fmta("\\sec{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "cot", name = "cot", snippetType = "autosnippet" },
    fmta("\\cot{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "asin", name = "arcsin", snippetType = "autosnippet" },
    fmta("\\arcsin{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "acos", name = "arccos", snippetType = "autosnippet" },
    fmta("\\arccos{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "atan", name = "arctan", snippetType = "autosnippet" },
    fmta("\\arctan{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  ---latex-symbol
  s({ trig = "...", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\dots",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "c.", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\cdot",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "cdots", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\cdots",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "v.", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\vdots",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "iff", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\iff",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "inn", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\in",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "notin", wordTrig = false, snippetType = "autosnippet" }, {
    t "not\\in",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "aa", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\forall",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "ee", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\exists",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "!=", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\neq",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "==", wordTrig = false, snippetType = "autosnippet" }, {
    t "&=",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "~=", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\approx",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "~~", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\sim",
  }, { condition = markdown.in_mathzone }),
  s({ trig = ">=", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\geq",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "<=", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\leq",
  }, { condition = markdown.in_mathzone }),
  s({ trig = ">>", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\gg",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "<<", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\ll",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "to", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\to",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "mto", wordTrig = false, snippetType = "autosnippet", priority = 1001 }, {
    t "\\mapsto",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "\\\\\\", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\setminus",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "||", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\mid ",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "nmid", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\nmid",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "sr", wordTrig = false, snippetType = "autosnippet" }, {
    t "^2",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "cb", wordTrig = false, snippetType = "autosnippet" }, {
    t "^3",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "inv", wordTrig = false, snippetType = "autosnippet" }, {
    t "^{-1}",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "**", wordTrig = false, snippetType = "autosnippet" }, {
    t "^*",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "  ", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\,",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "<>", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\diamond",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "+-", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\pm",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "-+", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\mp",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "rhs", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\mathrm{R.H.S}",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "lhs", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\mathrm{L.H.S}",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "cap", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\cap",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "cup", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\cup",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "sub", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\subseteq",
  }, { condition = markdown.in_mathzone }),
  -- s({ trig = "sup", wordTrig = false, snippetType = "autosnippet" }, {
  --   t("\\supseteq"),
  -- }, { condition = markdown.in_mathzone }),
  s({ trig = "oo", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\infty",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "tp", wordTrig = false, snippetType = "autosnippet" }, {
    t "^\\top",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "dr", wordTrig = false, snippetType = "autosnippet" }, {
    t "^\\dagger",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "perp", wordTrig = false, snippetType = "autosnippet" }, {
    t "^\\perp",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "ss", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\star",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "oxx", wordTrig = false, snippetType = "autosnippet" }, {
    t " \\otimes ",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "xx", wordTrig = false, snippetType = "autosnippet" }, {
    t " \\times ",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "=>", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\implies",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "llr", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\longleftrightarrow",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "cir", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\circ",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "iso", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\cong",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "ihbar", wordTrig = false, snippetType = "autosnippet", priority = 2000 }, {
    t "i\\hbar",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "hbar", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\hbar",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "bar", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\bar",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "uns", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\unlhd",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "eqv", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\equiv",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "##", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\#",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "ell", wordTrig = false, snippetType = "autosnippet", priority = 2000 }, {
    t "\\ell",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "nn", wordTrig = false, snippetType = "autosnippet", priority = 2000 }, {
    t "\\not",
  }, { condition = markdown.in_mathzone }),
  s({ trig = "par", wordTrig = false, snippetType = "autosnippet", priority = 2000 }, {
    t "\\partial",
  }, { condition = markdown.in_mathzone }),
  s(
    { trig = "jk", wordTrig = false, snippetType = "autosnippet" },
    fmta(
      [[
    _{<>}
    ]],
      { i(0) }
    ),
    { condition = markdown.in_mathzone }
  ),
  s(
    { trig = "kj", wordTrig = false, snippetType = "autosnippet" },
    fmta(
      [[
    ^{<>}
    ]],
      { i(0) }
    ),
    { condition = markdown.in_mathzone }
  ),
}
