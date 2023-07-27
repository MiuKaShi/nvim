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
  { "h-hg/fcitx.nvim", event = "InsertEnter" },
  { "wakatime/vim-wakatime", event = "InsertEnter" },
  {
    "MiuKaShi/vim-gf-list",
    keys = "gf",
    config = function()
      vim.g.GfList_map_n_gf = "gf"
      vim.g.GfList_map_v_gf = "gf"
    end,
  },
  { "junegunn/fzf", build = "./install --bin", event = "VeryLazy" },
  -- { 'skywind3000/asyncrun.vim', cmd = 'AsyncRun' } -- 异步运行
}
