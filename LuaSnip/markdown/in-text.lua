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
local markdown = require "snippets.markdown"

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  -- equation
  s({ trig = "ii", snippetType = "autosnippet" }, fmta("$<>$", i(1)), { condition = markdown.in_text }),
  s({ trig = "dd", snippetType = "autosnippet" }, fmta("$$\n<>\n$$", i(1)), { condition = markdown.in_text }),
  -- code
  s(
    { trig = ";c", snippetType = "autosnippet", name = "Insert fenced code block" },
    fmta(
      [[
      ```<>
      <>
      ```
      ]],
      { i(1), i(0) }
    ),
    { condition = markdown.in_text }
  ),
  s(
    { trig = ";s", snippetType = "autosnippet", name = "strikethrough" },
    fmta("~~<>~~", { i(1) }),
    { condition = markdown.in_text }
  ),
  -- text
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
    ),
    { condition = markdown.in_text }
  ),
  s(
    { trig = "bbox", snippetType = "autosnippet", name = "Insert box" },
    fmta(
      [[
  :::{.box}

  Content<>

  :::
      ]],
      { i(1) }
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
}
