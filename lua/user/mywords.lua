local M = {}

function M.config()
    vim.keymap.set('n', '<leader>hh', "<cmd>lua require'mywords'.hl_toggle()<CR>")
    vim.keymap.set('n', '<leader>hx', "<cmd>lua require'mywords'.uhl_all()<CR>")
end

return M
