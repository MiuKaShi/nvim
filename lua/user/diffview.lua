local M = {}

function M.setup()
    local status_ok, diffview = pcall(require, 'diffview')
    if status_ok then
        diffview.setup {
            enhanced_diff_hl = true,
        }
    end
end

return M
