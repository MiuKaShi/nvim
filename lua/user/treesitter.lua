local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

local langs = {
    'bash',
    'python',
    'query',
    'c',
    'cpp',
    'cmake',
    'css',
    'comment',
    'diff',
    'dockerfile',
    'go',
    'json',
    'latex',
    'lua',
    'toml',
    'yaml',
    'julia',
}

configs.setup {
    ensure_installed = langs,
    highlight = { enable = true },
    incremental_selection = { enable = true },
    indent = { enable = true },
    rainbow = { enable = true },
    playground = { enable = true },
    query_linter = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['as'] = '@statement.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
                [']}'] = '@block.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
                [']{'] = '@block.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
                ['[{'] = '@block.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
                ['[}'] = '@block.outer',
            },
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
                ['<leader>df'] = '@function.outer',
                ['<leader>dc'] = '@class.outer',
                ['<leader>db'] = '@block.outer',
            },
        },
    },
}

-- Folding
-- vim.opt_local.foldmethod = 'expr'
-- vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
