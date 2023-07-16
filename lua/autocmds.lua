local autocmd = vim.api.nvim_create_autocmd

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
        -- vim.opt.guicursor = vim.opt.guicursor + { "a:ver25-blink100" }  -- Verical cursor
        vim.opt.guicursor = vim.opt.guicursor + { 'a:block-blink100' } -- Block cursor
    end,
})

-- Don't continue comments
autocmd('BufEnter', {
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
    end,
})

-- Equalize splites
autocmd('VimResized', {
    callback = function()
        vim.cmd 'wincmd ='
    end,
    desc = 'Equalize Splits',
})

-- Disable diagnostic for rofi config
autocmd('BufEnter', {
    pattern = '*.rasi',
    callback = function()
        vim.diagnostic.disable()
    end,
    desc = 'No Lsp error for rofi config',
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
