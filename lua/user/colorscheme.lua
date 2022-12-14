local colorscheme = 'gruvbox'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    return
end

-- 透明设置
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd [[
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi LineNR guibg=NONE ctermbg=NONE
hi CursorLineNR guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi MsgArea ctermbg=NONE guibg=NONE
hi Pmenu guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
]]
