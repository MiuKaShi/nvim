local M = {}

function M.config()
    vim.keymap.set('n', ']t', function()
        require('todo-comments').jump_next()
    end, { desc = 'Next todo comment' })

    vim.keymap.set('n', '[t', function()
        require('todo-comments').jump_prev()
    end, { desc = 'Previous todo comment' })
end

function M.setup()
    local status_ok, todo = pcall(require, 'todo-comments')
    if status_ok then
        todo.setup {
            signs = false, -- show icons in the signs column
        }
    end
end

return M
