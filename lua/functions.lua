-- Toggle hidden_all
vim.g.hidden_all = 0
vim.diagnostic.disable()
function ToggleHiddenAll()
    if vim.g.hidden_all == 0 then
        vim.g.hidden_all = 1
        vim.diagnostic.disable()
        vim.opt.showmode = false
        vim.opt.ruler = false
        vim.opt.laststatus = 0
        vim.opt.showcmd = false
        vim.opt.signcolumn = 'no'
    else
        vim.g.hidden_all = 0
        vim.diagnostic.enable()
        vim.opt.showmode = true
        vim.opt.ruler = true
        vim.opt.laststatus = 2
        vim.opt.showcmd = true
        vim.opt.signcolumn = 'yes'
    end
end

-- Change directory
vim.api.nvim_create_user_command('ChangeDirectory', function()
    vim.cmd [[lcd%:p:h]]
    vim.notify 'Directory changed'
end, { desc = 'Command to change directory' })

--- Change the number column between relative and fixed
vim.api.nvim_create_user_command('ToggleNumber', function()
    local number = vim.wo.number -- local to window
    local relativenumber = vim.wo.relativenumber -- local to window
    if number and relativenumber then
        vim.wo.relativenumber = false
    elseif number then
        vim.wo.relativenumber = true
    end
end, { desc = 'Toggle Number' })

-- Qucikfix window
vim.api.nvim_create_user_command('QuickFixToggle', function()
    local windows = vim.fn.getwininfo()
    for i = 1, vim.tbl_count(windows) do
        local tbl = windows[i]
        if tbl.quickfix == 1 then
            vim.cmd 'cclose'
        else
            vim.cmd 'horizontal botright copen' -- Open quickfix window horizontally
        end
    end
end, { desc = 'Toggle Qucikfix' })
