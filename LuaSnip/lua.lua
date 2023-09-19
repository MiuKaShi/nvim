local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
return {
  s("p", {
    t "print(",
    i(1),
    t ")",
  }),

  s("if", {
    t { "if " },
    i(1),
    t { " then", "\t" },
    i(2),
    t { "", "end" },
    i(0),
  }),

  s("elseif", {
    t { "elseif " },
    i(1),
    t { " then", "\t" },
    i(0),
  }),

  s("rt", {
    t "return ",
  }),

  s(
    "ll",
    fmt(
      [[
    local {} = {}
    ]],
      { i(1), i(2) }
    )
  ),

  s(
    "req",
    fmt(
      [[
    require("{}")
    ]],
      i(1)
    )
  ),

  s("l", t "local "),

  s(
    "class",
    fmta(
      [[
    local <> = {}
    <class>.__index = <class>

    function <class>:new(<>)
        local <> = self ~= <class> and self or setmetatable({}, self)
        <>
        return <>
    end
    ]],
      {
        i(1, "Class"),
        class = f(function(args) return args[1] end, { 1 }),
        i(2),
        i(3, "o"),
        i(0),
        f(function(args) return args[1] end, { 3 }),
      }
    )
  ),
  ls.parser.parse_snippet("lm", "local M = {}\n\n$1 \n\nreturn M"),
}
