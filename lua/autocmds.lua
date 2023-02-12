local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
augroup('HighlightYank', { clear = true })
autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank { on_visual = true, timeout = 100 }
    end,
    group = 'HighlightYank',
    desc = 'Highlight the yanked text',
})
