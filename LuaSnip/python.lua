local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local conds_expand = require "luasnip.extras.conditions.expand"
local pos = require "snippets.position"
return {
  s(
    { trig = "env", name = "python3 environment", dscr = "Declare py3 environment" },
    { t { "#!/usr/bin/env python3", "" } },
    {
      condition = pos.on_top * conds_expand.line_begin,
      show_condition = pos.on_top * pos.line_begin,
    }
  ),
}
