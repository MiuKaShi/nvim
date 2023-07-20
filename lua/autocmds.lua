local autocmd = vim.api.nvim_create_autocmd

-- 光标回到上次位置
autocmd('BufReadPost', {
    callback = function()
        local last_pos = vim.fn.line '\'"'
        local total_lines = vim.fn.line '$'
        if last_pos > 1 and last_pos <= total_lines then
            vim.cmd [[normal! g`"]]
        end
    end,
    pattern = '*',
})

-- Highlight on yank
autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200, on_visual = true }
    end,
    pattern = '*',
})

-- Fixing cursor
autocmd('VimLeave', {
    pattern = '*',
    callback = function()
        vim.opt.guicursor = vim.opt.guicursor + { 'a:block-blink100' } -- Block cursor
    end,
})

-- Equalize splites 均分
autocmd('VimResized', {
    callback = function()
        vim.cmd 'wincmd ='
    end,
    desc = 'Equalize Splits',
})

-- For suckless
autocmd({ 'BufWritePost' }, {
    pattern = '.Xresources',
    callback = function()
        vim.cmd '!xrdb %'
        vim.cmd '!pidof st | xargs kill -s USR1'
    end,
    desc = 'Reload st terminal',
})
