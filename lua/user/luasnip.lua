local M = {}

function M.setup()
    local status_ok, luasnip = pcall(require, 'luasnip')
    if status_ok then
        local types = require 'luasnip.util.types'
        luasnip.setup {
            update_events = 'TextChanged,TextChangedI',
            enable_autosnippets = true,
            store_selection_keys = '`',
            ext_opts = {
                [types.choiceNode] = { active = { virt_text = { { '« ', 'NonText' } } } },
            },
        }
    end
end

return M
