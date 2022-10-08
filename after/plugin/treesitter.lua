local ts_install = {
    "bash",
    "python",
    "query",
    "swift",
    "c",
    "cpp",
    "cmake",
    "css",
    'comment',
    "dockerfile",
    "go",
    "json",
    "vue",
    'bibtex',
    'html',
    'latex',
    'lua',
    'ruby',
    'toml',
    'vim',
    'yaml',
    'julia'
}

require('nvim-treesitter.configs').setup {
    ensure_installed = ts_install,
    highlight = { enable = true, additional_vim_regex_highlighting = { 'latex' } },
    incremental_selection = { enable = true },
    indent = { enable = true },
    playground = { enable = true },
    query_linter = { enable = true },
}

-- Folding
-- vim.opt_local.foldmethod = 'expr'
-- vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
