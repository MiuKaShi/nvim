require('neorg').setup {
    load = {
        ['core.defaults'] = {},
        ['core.keybinds'] = {
            config = {
                neorg_leader = ',',
                hook = function(keybinds)
                    keybinds.unmap('norg', 'i', '<C-l>')
                    keybinds.unmap('norg', 'n', '<C-s>')
                end,
            },
        },
        ['core.norg.concealer'] = {},
        ['core.norg.dirman'] = {
            config = {
                workspaces = { notes = '~/neorg/notes', tasks = '~/neorg/tasks' },
            },
        },
        ['core.gtd.base'] = { config = { workspace = 'gtd' } },
        ['core.norg.completion'] = { config = { engine = 'nvim-cmp' } },
        ['core.norg.qol.toc'] = {},
        ['core.integrations.telescope'] = {},
    },
}
