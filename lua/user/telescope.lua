local M = {}

function M.config()
    local tb = require 'telescope.builtin'
    local te = require('telescope').extensions
    local themes = require 'telescope.themes'

    vim.keymap.set('n', '<leader>fr', function()
        te.frecency.frecency(themes.get_ivy {})
    end, { desc = 'Recent Files' })

    vim.keymap.set('n', 'ms', function()
        te.vim_bookmarks.all { hide_filename = false, shorten_path = true }
    end, { desc = 'Recent Files' })

    vim.keymap.set('n', '<leader>fs', function()
        tb.treesitter(themes.get_ivy {})
    end, { desc = 'Search Functions/variables' })

    vim.keymap.set('n', '<leader>/', function()
        tb.live_grep { previewer = false }
    end, { desc = 'fuzz find' })

    vim.keymap.set('n', '<leader>fl', tb.lsp_document_symbols, { desc = 'LSP search' })
    vim.keymap.set('n', '<leader>fw', tb.grep_string, { desc = 'Find cursor word' })
    vim.keymap.set('n', '<leader>ff', tb.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fm', tb.builtin, { desc = 'Telescope Meta' })
    vim.keymap.set('n', '<leader>fh', tb.help_tags, { desc = 'Help Tags' })
    vim.keymap.set('n', '<C-f>', tb.current_buffer_fuzzy_find, { desc = 'Search current buffer' })
    vim.keymap.set('n', '<leader>bl', tb.buffers, { desc = 'buffer list' })
    vim.keymap.set('n', '<leader>gc', tb.git_commits, { desc = 'git commits' })
    vim.keymap.set('n', '<leader>gb', tb.git_branches, { desc = 'git branches' })
end

function M.setup()
    local status_ok, telescope = pcall(require, 'telescope')
    if status_ok then
        local home = os.getenv 'HOME'
        local themes = require 'telescope.themes'
        telescope.setup {
            defaults = {
                sorting_strategy = 'ascending',
                layout_config = {
                    prompt_position = 'top',
                    width = 0.8,
                    height = 0.9,
                    horizontal = {
                        preview_cutoff = 0,
                    },
                },
                prompt_prefix = '   ',
                selection_caret = ' ',
                path_display = { 'absolute' },
                set_env = { ['COLORTERM'] = 'truecolor' },
                file_ignore_patterns = {
                    '.git/',
                    'target/',
                    'docs/',
                    'vendor/*',
                    '%.lock',
                    '__pycache__/*',
                    '%.sqlite3',
                    '%.ipynb',
                    'node_modules/*',
                    '%.jpg',
                    '%.jpeg',
                    '%.png',
                    '%.svg',
                    '%.otf',
                    '%.ttf',
                    '%.webp',
                    '.dart_tool/',
                    '.github/',
                    '.gradle/',
                    '.idea/',
                    '.settings/',
                    '.vscode/',
                    '__pycache__/',
                    'build/',
                    'env/',
                    'gradle/',
                    'node_modules/',
                    '%.pdb',
                    '%.dll',
                    '%.class',
                    '%.exe',
                    '%.cache',
                    '%.ico',
                    '%.pdf',
                    '%.dylib',
                    '%.jar',
                    '%.docx',
                    '%.met',
                    'smalljre_*/*',
                    '.vale/',
                    '%.burp',
                    '%.mp4',
                    '%.mkv',
                    '%.rar',
                    '%.zip',
                    '%.7z',
                    '%.tar',
                    '%.bz2',
                    '%.epub',
                    '%.flac',
                    '%.tar.gz',
                },
                mappings = {
                    i = {
                        ['<C-a>'] = { '<esc>0i', type = 'command' },
                        ['<Esc>'] = require('telescope.actions').close,
                    },
                },
            },
            pickers = {
                buffers = { theme = 'dropdown', sort_lastused = true, previewer = false },
                current_buffer_fuzzy_find = { previewer = false },
                find_files = {
                    theme = 'ivy',
                    follow = true,
                    hidden = true,
                    find_command = {
                        'rg',
                        '--no-ignore',
                        '--files',
                        '--hidden',
                        '--glob',
                        '!.git/*',
                        '--glob',
                        '!**/.Rproj.user/*',
                        '-L',
                    },
                },
                grep_string = { path_display = { 'shorten' } },
                live_grep = { path_display = { 'shorten' } },
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
                file_browser = { theme = 'ivy', hijack_netrw = true },
                ['ui-select'] = { themes.get_dropdown() },
            },
        }
        local extensions = {
            'file_browser',
            'frecency',
            'ui-select',
            'vim_bookmarks',
        }
        for _, ext in ipairs(extensions) do
            require('telescope').load_extension(ext)
        end
    end
end

return M
