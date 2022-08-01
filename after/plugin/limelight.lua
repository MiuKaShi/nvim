-- Limelight 设置
vim.g.limelight_conceal_ctermfg     = 'gray'
vim.g.limelight_conceal_ctermfg     = 240
vim.g.limelight_conceal_guifg       = 'DarkGray'
vim.g.limelight_conceal_guifg       = '#777777'
vim.g.limelight_default_coefficient = 0.7
vim.cmd [[
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
]]
