local M = {}

function M.config()
    vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<CR>') -- Trouble
end

function M.setup()
    local status_ok, trouble = pcall(require, 'trouble')
    if status_ok then
        trouble.setup {
            position = 'bottom',
            signs = {
                error = '🔥',
                warning = '💩',
                hint = '💡',
                information = '💬',
                other = '📌',
            },
            use_diagnostic_sign = true,
        }
    end
end

return M
