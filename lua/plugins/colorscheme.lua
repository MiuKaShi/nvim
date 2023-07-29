return {
  -- gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup {
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      }
      -- load the colorscheme here
      vim.cmd [[colorscheme gruvbox]]
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
  -- citruszest
  -- {
  --   "zootedb0t/citruszest.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
}
