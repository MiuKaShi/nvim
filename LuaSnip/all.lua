local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep
local context = require 'snippets.context'
local username = vim.env.USER:gsub('^%l', string.upper)
return {
    s(
        'date',
        f(function()
            return os.date '%D - %H:%M'
        end)
    ),
    s('choicenode', c(1, { t 'choice 1', t 'choice 2', t 'choice 3' })),
    s({ trig = 'todo', name = 'TODO', dscr = 'TODO:' }, {
        t('TODO(' .. username .. '): '),
        p(os.date, '%Y-%m-%d '),
    }, { condition = context.in_comments, show_condition = context.in_comments }),
    s({ trig = 'fix', name = 'FIXME', dscr = 'FIXME:' }, {
        t('FIXME(' .. username .. '): '),
        p(os.date, '%Y-%m-%d '),
    }, { condition = context.in_comments, show_condition = context.in_comments }),
    s({ trig = 'hack', name = 'HACK', dscr = 'HACK:' }, {
        t('HACK(' .. username .. '): '),
        p(os.date, '%Y-%m-%d '),
    }, { condition = context.in_comments, show_condition = context.in_comments }),
    s({ trig = 'note', name = 'NOTE', dscr = 'NOTE:' }, {
        t('NOTE(' .. username .. '): '),
        p(os.date, '%Y-%m-%d '),
    }, { condition = context.in_comments, show_condition = context.in_comments }),
}
