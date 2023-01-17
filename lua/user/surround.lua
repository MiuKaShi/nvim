local M = {}

function M.config()
    local status_ok, surround = pcall(require, 'nvim-surround')
    if status_ok then
        surround.setup {
            move_cursor = false,
            keymaps = {
                insert = '<C-g>s',
                visual = 's',
            },
            aliases = { -- aliases should match the bindings further above
                ['b'] = ')',
                ['c'] = '}',
                ['r'] = ']',
                ['q'] = '"',
                ['z'] = "'",
            },
        }
    end
end

return M
