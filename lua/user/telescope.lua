local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    return
end

local home = os.getenv 'HOME'
local themes = require 'telescope.themes'

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
        selection_caret = ' ',
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
    pickers = {
        buffers = {
            theme = 'dropdown',
            sort_lastused = true,
            previewer = false,
        },
        current_buffer_fuzzy_find = {
            previewer = false,
        },
        find_files = {
            theme = 'ivy',
            follow = true,
        },
        grep_string = {
            path_display = { 'shorten' },
        },
        live_grep = {
            path_display = { 'shorten' },
        },
    },
    extensions = {
        frecency = {
            theme = themes.get_dropdown,
            show_scores = true,
            workspaces = {
                ['conf'] = home .. '/.config',
                ['note'] = home .. '/notes',
                ['proj'] = home .. '/Projects',
            },
        },
        file_browser = {
            theme = 'ivy',
            hijack_netrw = true,
        },
        ['ui-select'] = themes.get_dropdown(),
    },
}

local extensions = {
    'file_browser',
    'frecency',
    'ui-select',
    'aerial',
}
for _, ext in ipairs(extensions) do
    require('telescope').load_extension(ext)
end

local tb = require 'telescope.builtin'
local te = require('telescope').extensions

vim.keymap.set('n', '<leader>ff', function()
    tb.treesitter(themes.get_ivy {})
end, { desc = 'Search Functions/variables' })

vim.keymap.set('n', '<leader>fr', function()
    te.frecency.frecency(themes.get_ivy {})
end, { desc = 'Recent Files' })

vim.keymap.set('n', '<leader>fs', tb.current_buffer_fuzzy_find, { desc = 'Search current buffer' })
vim.keymap.set('n', '<leader>fw', tb.grep_string, { desc = 'Find cursor word' })
vim.keymap.set('n', '<leader>fd', tb.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<C-f>', tb.treesitter, { desc = 'Find variables' })
vim.keymap.set('n', '<leader>fm', tb.builtin, { desc = 'Telescope Meta' })
vim.keymap.set('n', '<leader>fh', tb.help_tags, { desc = 'Help Tags' })
