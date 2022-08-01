local telescope = require 'telescope'
local home = os.getenv 'HOME'
local themes = require 'telescope.themes'

telescope.load_extension 'file_browser'
telescope.setup {
    defaults = {
        sorting_strategy = 'ascending',
        layout_config = {
            horizontal = {
                height = 0.9,
                preview_cutoff = 120,
                prompt_position = 'top',
                width = 0.8,
            },
        },
        prompt_prefix = '   ',
        selection_caret = ' ',
        path_display = { 'absolute' },
        set_env = { ['COLORTERM'] = 'truecolor' },
        file_ignore_patterns = { '%.jpeg$', '%.jpg$', '%.png$', '%.pdf$' },
        mappings = {
            i = {
                ['<C-a>'] = { '<esc>0i', type = 'command' },
                ['<Esc>'] = require('telescope.actions').close,
            },
        },
    },
    extensions = {
        frecency = {
            show_scores = true,
            workspaces = {
                ['conf'] = home .. '/.config',
                ['cv']   = home .. '/Documents/CV',
                ['ex']   = home .. '/Documents/Exercises',
                ['org']  = home .. '/Documents/neorg',
                ['note'] = home .. '/Documents/Notes',
                ['proj'] = home .. '/Documents/Projects',
                ['site'] = home .. '/my_site',
                ['talk'] = home .. '/Documents/Talks',
                ['tex']  = home .. '/Tex',
            },
        },
        ['ui-select'] = { themes.get_dropdown {} },
    },
}
