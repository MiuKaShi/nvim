vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4

vim.g.latex_to_unicode_tab = 'off'
vim.g.latex_to_unicode_suggestions = 0
vim.g.julia_indent_align_brackets = true
vim.g.julia_indent_align_funcargs = true

vim.cmd [[
iabbrev <buffer> != ≠
iabbrev <buffer> !== ≢
iabbrev <buffer> === ≡
iabbrev <buffer> <= ≤
iabbrev <buffer> >= ≥
]]
