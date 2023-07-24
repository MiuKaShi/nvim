vim.g.tex_flavor = 'latex'

vim.opt_local.conceallevel = 2
vim.opt_local.spell = true

vim.keymap.set('n', '<leader>cl', vim.cmd.TexlabBuild, { desc = 'Build LaTeX' })
vim.keymap.set('n', '<leader>pp', vim.cmd.TexlabForward, { desc = 'Forward Search' })

require('nvim-surround').buffer_setup {
    surrounds = {
        ['"'] = {
            add = { '``', "''" },
            find = "``.-''",
            delete = "^(``)().-('')()$",
        },
        ['$'] = {
            add = { '\\(', '\\)' },
            find = '\\%(.-\\%)',
            delete = '^(\\%()().-(\\%))()$',
            change = {
                target = '^\\(%()().-(\\%))()$',
                replacement = function()
                    return { { '[', '\t' }, { '', '\\]' } }
                end,
            },
        },
    },
}
