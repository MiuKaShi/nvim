local M = {}

function M.setup()
    local status_ok, luasnip = pcall(require, 'luasnip')
    if status_ok then
        local types = require 'luasnip.util.types'
        luasnip.setup {
            update_events = 'TextChanged,TextChangedI',
            enable_autosnippets = true,
            ext_opts = {
                [types.choiceNode] = { active = { virt_text = { { '« ', 'NonText' } } } },
            },
        }
    end
end

return M
