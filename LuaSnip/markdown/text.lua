local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local p = require("luasnip.extras").partial
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local conds_expand = require "luasnip.extras.conditions.expand"
local pos = require "snippets.position"

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  s({ trig = "meta", name = "Markdown front matter (YAML format)" }, {
    t { "---", "title: " },
    i(1),
    t { "", "date: " },
    p(os.date, "%Y-%m-%dT%H:%M:%S+0800"),
    t { "", 'tags: ["' },
    i(2),
    t { '"]', 'categories: ["' },
    i(3),
    t { '"]', 'series: ["' },
    i(4),
    t { '"]', "---", "", "" },
    i(0),
  }, {
    condition = pos.on_top * conds_expand.line_begin,
    show_condition = pos.on_top * pos.line_begin,
  }),
  s(
    { trig = ";l", name = "Markdown Links", dscr = "Insert a Link" },
    fmta("[<>](<>)", { i(1), f(function(_, snip) return snip.env.TM_SELECTED_TEXT[1] or {} end, {}) })
  ),
  s(
    { trig = ";q", name = "Q&A" },
    fmta(
      [[
                **Q<>:** <>
                **A:** <>

                *Answer:*
            ]],
      {
        i(1),
        d(2, get_visual),
        i(3),
      }
    )
  ),
  s({ trig = ";b", snippetType = "autosnippet", name = "bold" }, fmta("**<>**", { i(1) })),
  s({ trig = ";t", snippetType = "autosnippet", name = "italic" }, fmta("*<>*", { i(1) })),
  s({ trig = ";s", snippetType = "autosnippet", name = "strikethrough" }, fmta("~~<>~~", { i(1) })),
  s(
    { trig = "bbox", snippetType = "autosnippet", name = "Insert box" },
    fmta(
      [[
  :::{.box}

  Content<>

  :::
      ]],
      { i(1)  }
    )
  ),
  s(
    { trig = "box1", snippetType = "autosnippet", name = "Insert black box" },
    fmta(
      [[
  :::{.box .black}
	 >> Title<>

  Content<>

  :::
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    { trig = "box2", snippetType = "autosnippet", name = "Insert red box" },
    fmta(
      [[
  :::{.box .red}
	 >> Title<>

  Content<>

  :::
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    { trig = "box3", snippetType = "autosnippet", name = "Insert blue box" },
    fmta(
      [[
  :::{.box .blue}
	 >> Title<>

  Content<>

  :::
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    { trig = "box4", snippetType = "autosnippet", name = "Insert green box" },
    fmta(
      [[
  :::{.box .green}
	 >> Title<>

  Content<>

  :::
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    { trig = "box5", snippetType = "autosnippet", name = "Insert green box" },
    fmta(
      [[
  :::{.box .plain}

  Content<>

  :::
      ]],
      { i(1) }
    )
  ),
	s(
    { trig = ";c", snippetType = "autosnippet", name = "Insert fenced code block" },
    fmta(
      [[
      ```<>
      <>
      ```
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    { trig = ";i", name = "Image" },
    fmt(
      [[
			[{}]({} "{}") {}
			]],
      { i(1, "alt text"), i(2, "source"), i(3, "title"), i(0) }
    )
  ),
}
