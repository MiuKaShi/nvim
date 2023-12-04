local offset_first_n = function(match, _, _, pred, metadata)
  ---@cast pred integer[]
  local capture_id = pred[2]
  if not metadata[capture_id] then metadata[capture_id] = {} end

  local range = metadata[capture_id].range or { match[capture_id]:range() }
  local offset = pred[3] or 0

  range[4] = range[2] + offset
  metadata[capture_id].range = range
end

vim.treesitter.query.add_directive("offset-first-n!", offset_first_n, true)

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
        "foam",
        "toml",
        "yaml",
        "julia",
        "matlab",
        "regex",
        "vim",
        "vimdoc",
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

  -- rainbow brackets
  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  --text context
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    dependencies = "nvim-treesitter",
    opts = {
      max_lines = 3,
    },
  },

  -- tons of text objects
  {
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
