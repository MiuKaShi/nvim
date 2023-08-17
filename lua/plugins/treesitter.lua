return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPre",
    cmd = { "TSUpdateSync" },
    opts = {
      ensure_installed = {
        "bash",
        "python",
        "query",
        "c",
        "cpp",
        "cmake",
        "comment",
        "diff",
        "dockerfile",
        "go",
        "json",
        "latex",
        "lua",
        "luap",
        "luadoc",
        "toml",
        "yaml",
        "julia",
        "matlab",
        "regex",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
        disable = {
          "css",
          "latex",
          "markdown",
        },
        -- additional_vim_regex_highlighting = { "markdown" },
      },
      autopairs = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = "<TAB>",
        },
        is_supported = function()
          local mode = vim.api.nvim_get_mode().mode
          if mode == "c" then return false end
          return true
        end,
      },
      indent = { enable = false },
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        include_match_words = true,
        -- disable = { "c", "ruby" },
      },
      rainbow = {
        enable = true,
        disable = { "jsx" },
      },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },

  {
    "HiPhish/nvim-ts-rainbow2",
    event = "BufReadPost",
    dependencies = "nvim-treesitter",
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    dependencies = "nvim-treesitter",
    opts = {
      max_lines = 3,
    },
  },

  { -- tons of text objects
    "chrisgrieser/nvim-various-textobjs",
    lazy = true, -- loaded by keymaps
  },
  -- {
  --   "sustech-data/wildfire.nvim",
  --   event = "VeryLazy",
  --   dependencies = "nvim-treesitter",
  --   config = function() require("wildfire").setup() end,
  -- },
}
