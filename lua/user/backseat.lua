local M = {}

function M.config()
    -- openai 设置
    vim.g.backseat_openai_model_id = 'gpt-3.5-turbo'
    vim.g.backseat_language = 'chinese'

    vim.keymap.set('n', '<leader>bb', ':Backseat<CR>') -- auto comments
    vim.keymap.set('n', '<leader>bx', ':BackseatClear<CR>') -- clean comments
end

return M
