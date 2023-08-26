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

local function insert_delim(args, _, delim)
  local text = args[1][1]

  -- "fb" - followed by, "fs" - forward slash.
  local non_digit_fb_any_char_except_fs = string.find(text, "^%D.") and not string.find(text, "^\\")
  local digits_fb_non_digit = string.find(text, "^%d+%D")
  local fs_fb_non_spaces_fb_space = string.find(text, "^\\%S+%s")

  if non_digit_fb_any_char_except_fs or digits_fb_non_digit or fs_fb_non_spaces_fb_space then
    return delim
    -- Insert a space at the end of an expression without a delimiter.
  elseif delim == "}" then
    return " "
  else
    return ""
  end
end

-- Insert {} only when required to improve readability.
local function delim_get_visual(_, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, {
      f(insert_delim, { 1 }, { user_args = { "{" } }),
      i(1, parent.snippet.env.SELECT_RAW),
      f(insert_delim, { 1 }, { user_args = { "}" } }),
    })
  else
    return sn(nil, {
      f(insert_delim, { 1 }, { user_args = { "{" } }),
      i(1),
      f(insert_delim, { 1 }, { user_args = { "}" } }),
    })
  end
end

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

-- For reference:
--
-- local function fn(
--     args,     -- text from i(2) in this example i.e. { { "456" } }
--     parent,   -- parent snippet or parent node
--     l_delim,  -- user_args from opts.user_args
--     r_delim   -- user_args from opts.user_args
-- )
--     return '[' .. l_delim .. args[1][1] .. r_delim .. ']'
-- end
--
--     s({ name = "trig", trig = "trig", snippetType="autosnippet" },
--         fmta(
--             "<>--i(1) <> i(2)--<>--i(2) i(0)--<>",
--             {
--                 i(1),
--                 f(
--                     fn,  -- callback (args, parent, user_args) -> string
--                     {2}, -- node indice(s) whose text is passed to fn, i.e. i(2)
--                     { user_args = { "(", ")" }} -- opts
--                 ),
--                 i(2),
--                 i(0)
--             }
--         )
--     ),

return {
  -- equations.
  s({ trig = "ii", snippetType = "autosnippet" }, fmta("$<>$", i(1)), { condition = markdown.in_text }),
  s({ trig = "dd", snippetType = "autosnippet" }, fmta("$$\n<>\n$$", i(1)), { condition = markdown.in_text }),
  s(
    { trig = "ldd", name = "Align Math", snippetType = "autosnippet" },
    fmta(
      [[
            <>
            $$
            \begin{aligned}
                <>
            \end{aligned}
            $$
            <>
            ]],
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
        i(0),
      }
    ),
    { condition = markdown.in_text }
  ),
  s(
    { trig = "cdd", name = "Cases Math", snippetType = "autosnippet" },
    fmta(
      [[
            <>
            $$
            \begin{cases}
                <>
            \end{cases}
            $$
            <>
            ]],
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
        i(0),
      }
    ),
    { condition = markdown.in_text }
  ),
  s(
    { trig = "rdd", name = "Array Math", snippetType = "autosnippet" },
    fmta(
      [[
            <>
            $$
            \begin{array}{lcl}
                <>
            \end{array}
            $$
            <>
            ]],
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
        i(0),
      }
    ),
    { condition = markdown.in_text }
  ),

  s(
    { name = "Fraction", trig = "ff", snippetType = "autosnippet" },
    fmta("\\frac{<>}{<>}", {
      d(1, get_visual),
      i(2),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Prime", trig = "`", wordTrig = false, snippetType = "autosnippet" },
    { t "'" },
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Indefinite Integral", trig = "inti", snippetType = "autosnippet" },
    fmta("\\int <> \\,\\mathrm d<>", {
      d(1, get_visual),
      i(2, "x"),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Definite Integral", trig = "intd", snippetType = "autosnippet" },
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
    { name = "Derivative dy/dx", trig = "dyy", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\drv{d<>y}{dx<>}", {
      i(1),
      i(2),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Derivative d/dx", trig = "dxx", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\drv{d}{dx} \\left( <> \\right)", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Multiply Both Sides by", trig = "mbs", snippetType = "autosnippet" },
    fmta("\\quad \\biggr| \\times <>", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Boxed", trig = "box", snippetType = "autosnippet" },
    fmta("\\boxed{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Natural Logarithm", trig = "ln", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\ln{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { name = "Infinity", trig = "inf", snippetType = "autosnippet" },
    { t "\\infty" },
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Limit", trig = "lim", snippetType = "autosnippet" },
    fmta("\\lim_{<> \\to <>} <>", {
      i(1, "x"),
      i(2),
      d(3, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { name = "Implies", trig = "imp", snippetType = "autosnippet" },
    { t "\\implies" },
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Annotated Implies", trig = "aimp", snippetType = "autosnippet" },
    fmta("\\xRightarrow[<>]{<>}", {
      i(1),
      d(2, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Text", trig = "tek", snippetType = "autosnippet" },
    fmta("\\text{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Annotated Equals Sign", trig = "aeq", snippetType = "autosnippet" },
    fmta("\\overset{<>}{=}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "In Set", trig = "inset", snippetType = "autosnippet" },
    fmta("\\in \\mathbb{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Where", trig = "(, )whr", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\text{ where } <>", {
      f(function(_, snip) return snip.captures[1] end),
      i(0),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Tilde", trig = "~", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\tilde <>", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Hat", trig = "hat", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\hat <>", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Partial", trig = "pp", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\partial <>", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Bar", trig = "bar", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\bar <>", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Tag", trig = "tg", snippetType = "autosnippet" },
    fmta("\\tag{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Cancel", trig = "cnl", snippetType = "autosnippet" },
    fmta("\\cancel{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Cancel to", trig = "tcnl", snippetType = "autosnippet" },
    fmta("\\cancelto{<>}{<>}", {
      i(1),
      d(2, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "Not (crossed out)", trig = "cnot", snippetType = "autosnippet" },
    fmta("\\centernot{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
  s(
    { name = "sin", trig = "sin", snippetType = "autosnippet" },
    fmta("\\sin{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "cos", trig = "cos", snippetType = "autosnippet" },
    fmta("\\cos{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "tan", trig = "tan", snippetType = "autosnippet" },
    fmta("\\tan{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "cosec", trig = "csc", snippetType = "autosnippet" },
    fmta("\\csc{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "sec", trig = "sec", snippetType = "autosnippet" },
    fmta("\\sec{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "cot", trig = "cot", snippetType = "autosnippet" },
    fmta("\\cot{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "arcsin", trig = "asin", snippetType = "autosnippet" },
    fmta("\\arcsin{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "arccos", trig = "acos", snippetType = "autosnippet" },
    fmta("\\arccos{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),

  s(
    { name = "arctan", trig = "atan", snippetType = "autosnippet" },
    fmta("\\arctan{<>}", {
      d(1, get_visual),
    }),
    { condition = markdown.in_mathzone }
  ),
}
