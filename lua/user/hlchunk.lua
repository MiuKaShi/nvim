local M = {}

function M.setup()
    local status_ok, hlchunk = pcall(require, 'hlchunk')
    if status_ok then
        local langs = {
            help = true,
            aerial = true,
            alpha = true,
            dashboard = true,
            packer = true,
            Trouble = true,
            lspinfo = true,
            markdown = true,
            terminal = true,
            checkhealth = true,
            man = true,
            mason = true,
            NvimTree = true,
            ['neo-tree'] = true,
            ['markdown.pandoc'] = true,
            plugin = true,
            lazy = true,
            TelescopePrompt = true,
            [''] = true, -- because TelescopePrompt will set a empty ft, so add this.
        }
        hlchunk.setup {
            chunk = {
                enable = true,
                use_treesitter = true,
                notify = false,
                exclude_filetypes = langs,
                style = '#cc241d',
                chars = {
                    horizontal_line = '━',
                    left_top = '┏',
                    vertical_line = '┃',
                    left_bottom = '┗',
                    right_arrow = '━',
                },
            },
            indent = {
                enable = true,
                use_treesitter = false,
                exclude_filetypes = {
                    lua = true,
                    sh = true,
                    python = true,
                    c = true,
                    cpp = true,
                    diff = true,
                    yaml = true,
                    json = true,
                },
                chars = { '│', '¦', '┆', '┊' },
            },
            line_num = {
                enable = true,
                use_treesitter = false,
                style = '#fabd2f', ---@type '#008080'|'#8b8f81'|'#d79921' - Candidate colors.
            },
            blank = {
                enable = false,
                chars = { '·' },
                style = {
                    vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID 'Whitespace'), 'fg', 'gui'),
                },
            },
        }
    end
end

return M
