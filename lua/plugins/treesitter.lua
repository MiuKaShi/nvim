return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      init = function()
        vim.g.rainbow_delimiters = { query = { latex = 'rainbow-delimiters' } }
      end,
      'HiPhish/nvim-ts-rainbow2',
    },
    opts = {
      ensure_installed = {
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
      },
      highlight = {
        enable = true,
        disable = { 'markdown' },
        -- additional_vim_regex_highlighting = { 'markdown' },
      },
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
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
