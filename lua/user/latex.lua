local M = {}

function M.setup()
    local status_ok, latex = pcall(require, 'latex')
    if status_ok then
        latex.setup {
            conceals = {
                add = {
                    ['colon'] = ':',
                    ['coloneqq'] = '≔',
                },
            },
            imaps = {
                enabled = false,
                add = { ['\\emptyset'] = '0' },
                default_leader = ';',
            },
            surrounds = { enabled = true },
        }
    end
end

return M
