local M = {}

function M.setup()
    local status_ok, which_key = pcall(require, 'which-key')
    if status_ok then
        local setup = {
            plugins = {
                marks = true,
                registers = true,
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
                presets = {
                    operators = false,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                    z = true,
                    g = true,
                },
            },
            icons = {
                breadcrumb = '»',
                separator = '➜',
                group = '+',
            },
            popup_mappings = {
                scroll_down = '<c-d>',
                scroll_up = '<c-u>',
            },
            window = {
                border = 'rounded',
                position = 'bottom',
                margin = { 1, 0, 1, 0 },
                padding = { 2, 2, 2, 2 },
                winblend = 0,
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = 'left',
            },
            ignore_missing = true,
            hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
            show_help = true,
            triggers = 'auto',
            triggers_blacklist = {
                i = { 'j', 'k' },
                v = { 'j', 'k' },
            },
        }

        local opts = {
            mode = 'n', -- NORMAL mode
            prefix = '<leader>',
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }

        local mappings = {
            ['w'] = {
                name = '+Windows',
                s = { '<C-w>s', 'Split window below' },
                v = { '<C-w>v', 'Split window right' },
                ['-'] = { '<C-w>s', 'Split window below' },
                ['/'] = { '<C-w>v', 'Split window right' },
                w = { '<C-w>w', 'Other window' },
                j = { '<C-w>j', 'Go to the down window' },
                k = { '<C-w>k', 'Go to the up window' },
                h = { '<C-w>h', 'Go to the left window' },
                l = { '<C-w>l', 'Go to the right window' },
                q = { '<C-w>c', 'Close window' },
                m = { '<C-w>o', 'Maximize window' },
            },
            ['b'] = {
                name = '+Buffers',
                b = {
                    "<cmd>lua require('telescope.builtin').buffers { sort_mru = true }<CR>",
                    'List buffers',
                },
                n = { ':BufferLineCycleNext<CR>', 'Next buffer' },
                p = { ':BufferLineCyclePrev<CR>', 'Previous buffer' },
                d = { ':bw<CR>', 'Delete buffer' },
            },
            ['p'] = {
                name = '+Projects',
                f = { '<cmd>Telescope find_files<CR>', 'Find file by name(<CTRL-P>)' },
                a = {
                    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
                    'Add Workspace Folder',
                },
                r = {
                    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
                    'Remove Workspace Folder',
                },
                l = {
                    '<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>',
                    'List Workspace Folder',
                },
            },
            ['j'] = {
                name = '+Jump',
                i = {
                    "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>",
                    'Jump to symbol',
                },
            },
            ['g'] = {
                name = '+Git',
                c = {
                    "<cmd> lua require('telescope.builtin').git_commits()<CR>",
                    'Show commits',
                }, -- git commits 可过滤
                b = {
                    "<cmd> lua require('telescope.builtin').git_branches()<CR>",
                    'Show branches',
                }, -- git branchs 可过滤
                d = {
                    '<cmd>DiffviewOpen<CR>',
                    'Diff View',
                }, -- open diff view
                x = {
                    '<cmd>DiffviewClose<CR>',
                    'Close Diff View',
                }, -- close diff view
            },
            ['e'] = {
                name = '+Errors',
                a = {
                    "<cmd>lua require('telescope.builtin').diagnostics{ bufnr=0 }<CR>",
                    'List all errors',
                },
                k = {
                    '<cmd>lua vim.diagnostic.goto_prev()<CR>',
                    'diagnostic PREV',
                },
                j = {
                    '<cmd>lua vim.diagnostic.goto_next()<CR>',
                    'diagnostic NEXT',
                },
                f = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Fix error' },
            },
            ['c'] = {
                name = '+Compiler',
                c = { ':!compiler <c-r>%<CR><CR>', 'Compiler files' },
                p = { ':silent !st autoprev <c-r>%<CR><CR>', 'Compiler and preivew files' },
            },
            ['!'] = {
                ':Telescope help_tags theme=ivy<CR>',
                'Help commands by fuzzy search',
            }, -- vim帮助查找
            ['<Tab>'] = { ':b#<CR>', 'Last buffer' },
        }
        which_key.setup(setup)
        which_key.register(mappings, opts)
    end
end

return M
