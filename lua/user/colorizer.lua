local M = {}

function M.setup()
    local status_ok, colorizer = pcall(require, 'colorizer')
    if status_ok then
        colorizer.setup()
    end
end

return M
