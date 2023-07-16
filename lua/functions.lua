-- Toggle LSP
vim.cmd [[
let s:hidden_all = 0
lua vim.diagnostic.disable()
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        lua vim.diagnostic.disable()
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set signcolumn =no
    else
        let s:hidden_all = 0
        lua vim.diagnostic.enable()
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set signcolumn =yes
    endif
endfunction]]

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
