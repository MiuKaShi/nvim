local M = {}

function M.config()
    local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
    if status_ok then
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
        treesitter.setup {
            ensure_installed = langs,
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            context_commentstring = { enable = true, enable_autocmd = false },
            autopairs = { enable = true },
            incremental_selection = { enable = true },
            indent = { enable = false },
            rainbow = { enable = true },
        }
        -- Folding
        -- vim.opt_local.foldmethod = 'expr'
        -- vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
    end
end

return M
