local home = os.getenv 'HOME'
local themes = require 'telescope.themes'

require('telescope').setup {
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
	'file_browser', 'frecency', 'ui-select', 'aerial', 'notify', 'noice'
}
for _, ext in ipairs(extensions) do
	require('telescope').load_extension(ext)
end

local tb = require 'telescope.builtin'
local te = require('telescope').extensions

vim.keymap.set('n', '<leader>ff', function()
	tb.treesitter(themes.get_ivy {})
end, { desc = 'Search Functions/variables' })

vim.keymap.set('n', '<leader>fw', function()
	tb.grep_string(themes.get_ivy {})
end, { desc = 'Find cursor word' })

vim.keymap.set('n', '<leader>fr', function()
	te.frecency.frecency(themes.get_ivy {})
end, { desc = 'Recent Files' })

vim.keymap.set('n', '<leader>fs', function()
	tb.current_buffer_fuzzy_find({fuzzy = false,  case_mode = 'ignore_case', previewer = false})
end, { desc = 'Search current buffer' })

vim.keymap.set('n', '<leader>fd', function()
	tb.find_files(themes.get_ivy {})
end, { desc = 'Find Files' })

vim.keymap.set('n', '<leader>fm', function()
	tb.builtin()
end, { desc = 'Telescope Meta' })

vim.keymap.set('n', '<leader>fh', function()
	tb.help_tags { show_version = true }
end, { desc = 'Help Tags' })

