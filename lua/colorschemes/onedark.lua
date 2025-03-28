return {
  {
    "navarasu/onedark.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup {
        transparent = true,
      }
    end,
  },
}
