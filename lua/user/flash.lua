local M = {}

function M.setup()
    local status_ok, flash = pcall(require, 'flash')
    if status_ok then
        vim.keymap.set({ 'n', 'x', 'o' }, '<leader>f', flash.jump)
        vim.keymap.set({ 'n', 'x', 'o' }, '<leader>F', flash.treesitter)
        flash.setup {
            labels = 'asdfghjklqwertyuiopzxcvbnm',
            modes = {
                char = {
                    enabled = false,
                },
                treesitter_search = {
                    label = {
                        rainbow = { enabled = true },
                    },
                },
            },
        }
    end
end

return M
