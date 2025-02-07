return {

  -- supermaven
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    cmd = { "SupermavenToggle" },
    opts = {
      keymaps = {
        accept_suggestion = "<C-y>",
        clear_suggestion = "<C-c>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = {
        "help",
        "gitcommit",
        "gitrebase",
        "hgcommit",
        "svn",
        "cvs",
        "text",
        "markdown",
        "markdown.pandoc",
        "pandoc",
        "markdown_inline",
        "typst",
        "tex",
        "log",
      },
      log_level = "off", -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false, -- disables built in keymaps for more manual control
    },
    keys = {
      { "<leader>ai", "<cmd>SupermavenToggle<cr>", desc = "Toggle Supermaven [A][I]" },
    },
  },

  -- github copilot
  -- {
  --   "zbirenbaum/copilot.lua",
  --   build = ":Copilot auth",
  --   cmd = "Copilot",
  --   opts = {
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --       keymap = {
  --         accept = "<C-y>",
  --         close = "<Esc>",
  --         next = "<C-z>",
  --         prev = "<C-x>",
  --         select = "<CR>",
  --         dismiss = "<C-c>",
  --       },
  --     },
  --     panel = { enabled = false },
  --     filetypes = {
  --       yaml = false,
  --       markdown = false,
  --       text = false,
  --       pandoc = false,
  --       help = false,
  --       gitcommit = false,
  --       gitrebase = false,
  --       hgcommit = false,
  --       svn = false,
  --       cvs = false,
  --       ["."] = false,
  --     },
  --   },
  --   keys = {
  --     { "<leader>uc", function() require("copilot.suggestion").toggle_auto_trigger() end, desc = "Copilot toggle" },
  --   },
  -- },

  -- GPT
  -- {
  --   "james1236/backseat.nvim",
  --   cmd = {
  --     "Backseat",
  --     "BackseatAsk",
  --     "BackseatClear",
  --   },
  --   config = function()
  --     vim.g.backseat_openai_api_key = ""
  --     vim.g.backseat_openai_model_id = "gpt-3.5-turbo"
  --     vim.g.backseat_language = "chinese"
  --     vim.keymap.set("n", "<leader>ba", ":Backseat<CR>") -- auto comments
  --     vim.keymap.set("n", "<leader>bx", ":BackseatClear<CR>") -- clean comments
  --   end,
  -- },
}
