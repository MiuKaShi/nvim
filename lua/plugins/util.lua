return {

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
  { "kkharji/sqlite.lua", lazy = true },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function() vim.g.startuptime_tries = 10 end,
  },
  -- normal/insert模式切换的输入法记忆
  -- { "h-hg/fcitx.nvim", event = "InsertEnter" },
  { "wakatime/vim-wakatime", event = "InsertEnter" },
  {
    "MiuKaShi/vim-gf-list",
    keys = "gf",
    config = function()
      vim.g.GfList_map_n_gf = "gf"
      vim.g.GfList_map_v_gf = "gf"
      vim.g.GfList_terminal = "st"
      vim.g.GfList_editor = "nvim"
    end,
  },
  { "junegunn/fzf", build = "./install --bin", event = "VeryLazy" },
  -- { 'skywind3000/asyncrun.vim', cmd = 'AsyncRun' } -- 异步运行
  -- terminal manager
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm" },
    config = function()
      require("toggleterm").setup {
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        highlights = {
          NormalFloat = {
            link = "NvimTreeNormal",
          },
        },
        direction = "float",
        open_mapping = [[<c-\>]],
        close_on_exit = true,
        float_opts = {
          border = "single",
        },
        on_open = function(_, _, _, _) vim.cmd "set nocursorline" end,
      }
    end,
    keys = {
      { "<leader>e", function() require("util").togglecli "lf" end, desc = "lf manager" },
      { "<leader>g", function() require("util").togglecli "lazygit" end, desc = "git lazygit" },
    },
  },
}
