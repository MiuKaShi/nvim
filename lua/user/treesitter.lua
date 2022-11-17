local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

local ts_install = {
    'bash',
    'python',
    'query',
    'swift',
    'c',
    'cpp',
    'cmake',
    'css',
    'comment',
    'diff',
    'dockerfile',
    'go',
    'json',
    'vue',
    'bibtex',
    'html',
    'latex',
    'lua',
    'ruby',
    'toml',
    'vim',
    'yaml',
    'julia',
}

configs.setup {
    ensure_installed = ts_install,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'latex' },
    },
    incremental_selection = { enable = true },
    indent = { enable = true },
    rainbow = { enable = true, extended_mode = false },
    playground = { enable = true },
    query_linter = { enable = true },
}

-- Folding
-- vim.opt_local.foldmethod = 'expr'
-- vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
