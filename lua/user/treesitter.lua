local M = {}

function M.setup()
    local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
    if status_ok then
        local langs = {
            'bash',
            'python',
            'query',
            'c',
            'cpp',
            'cmake',
            'comment',
            'diff',
            'dockerfile',
            'go',
            'json',
            'latex',
            'lua',
            'luap',
            'luadoc',
            'toml',
            'yaml',
            'julia',
            'matlab',
            'regex',
            'vim',
            'vimdoc',
            'markdown',
            'markdown_inline',
        }
        treesitter.setup {
            ensure_installed = langs,
            highlight = {
                enable = true,
                disable = { 'markdown' },
                -- additional_vim_regex_highlighting = { 'markdown' },
            },
            context_commentstring = { enable = true, enable_autocmd = false },
            autopairs = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    node_incremental = '<CR>',
                    scope_incremental = '<TAB>',
                    node_decremental = '<BS>',
                },
            },
            indent = { enable = false },
            rainbow = {
                enable = true,
                disable = { 'jsx' },
            },
        }
        -- Folding
        -- vim.opt_local.foldmethod = 'expr'
        -- vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
    end
end

return M
