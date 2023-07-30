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
      vim.cmd [[
  hi Normal ctermbg=NONE guibg=NONE
  hi NonText ctermbg=NONE guibg=NONE
  hi LineNr guibg=NONE ctermbg=NONE
  hi CursorLineNr guibg=NONE ctermbg=NONE
  hi SignColumn ctermbg=NONE guibg=NONE
  hi MsgArea ctermbg=NONE guibg=NONE
  hi Pmenu guibg=NONE ctermbg=NONE
  hi EndOfBuffer guibg=NONE ctermbg=NONE
  hi NormalFloat guibg=NONE ctermbg=NONE
  hi FloatBorder guibg=NONE ctermbg=NONE
  ]]
    end,
  },
}
