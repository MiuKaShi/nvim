local M = {}

function M.setup()
    local status_ok, luasnip = pcall(require, 'luasnip')
    if status_ok then
        luasnip.config.set_config {
            history = true,
            delete_check_events = 'TextChanged',
            updateevents = 'TextChanged,TextChangedI',
            enable_autosnippets = true,
            store_selection_keys = '`',
            ext_opts = {
                [require('luasnip.util.types').choiceNode] = {
                    active = {
                        virt_text = { { '↺', 'markdownBold' } },
                    },
                },
            },
        }
    end
end

return M
