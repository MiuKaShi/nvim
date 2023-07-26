local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local conds_expand = require 'luasnip.extras.conditions.expand'
local pos = require 'snippets.position'
return {
  s(
    { trig = 'env', name = 'bash environment', dscr = 'Declare bas environment' },
    { t { '#!/usr/bin/env bash', '' } },
    {
      condition = pos.on_top * conds_expand.line_begin,
      show_condition = pos.on_top * pos.line_begin,
    }
  ),
  s(
    { trig = 'func', name = 'function', dscr = 'Define a function' },
    fmta(
      [[
		<>() {
				<>
		}
		]],
      { i(1), i(0) }
    )
  ),
  s(
    { trig = 'for', name = 'For Loop' },
    fmt(
      [[
			for (( i = 0; i < {}; i++ )); do
				{}
			done
	]],
      { i(1, '10'), i(0) }
    )
  ),
  s(
    { trig = 'forin', name = 'For In Loop' },
    fmta(
      [[
			for <> in <>; do
				<>
			done
	]],
      { i(1, 'VAR'), i(2, 'ITER'), i(0) }
    )
  ),
  s(
    'case',
    fmta(
      [[
		case <> in
			<> ) <>;;
		esac
    ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),
  s({ trig = 'if', name = 'If Statment' }, fmta('if [[ <> ]]; then\n  <>\nfi', { i(1, 'condition'), i(0) })),
  s({ trig = 'elif', name = 'Elif Statment' }, fmta('elif [[ <> ]]; then\n  <>', { i(1, 'condition'), i(0) })),
  s({ trig = 'until', name = 'Until Loop' }, fmta('until [[ <> ]]; do\n  <>\ndone', { i(1, 'condition'), i(0) })),
  s({ trig = 'while', name = 'While Loop' }, fmta('while [[ <> ]]; do\n  <>\ndone', { i(1, 'condition'), i(0) })),
}
