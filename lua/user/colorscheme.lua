-- Theme
vim.cmd [[colorscheme gruvbox]]
-- 透明设置
vim.g.gruvbox_contrast_dark = 'hard'
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
]]
