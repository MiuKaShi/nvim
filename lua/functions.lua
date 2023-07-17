-- Toggle diagnostic
vim.g.diagnostics_visible = false
vim.diagnostic.disable()
vim.api.nvim_create_user_command('ToggleDia', function()
    if vim.g.diagnostics_visible then
        vim.g.diagnostics_visible = false
        vim.diagnostic.disable()
        vim.opt.showmode = false
        vim.opt.ruler = false
        vim.opt.laststatus = 0
        vim.opt.showcmd = false
    else
        vim.g.diagnostics_visible = true
        vim.diagnostic.enable()
        vim.opt.showmode = true
        vim.opt.ruler = true
        vim.opt.laststatus = 2
        vim.opt.showcmd = true
    end
end, { desc = 'Toggle Diagnostic' })

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
