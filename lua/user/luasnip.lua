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

        -- snippets
        require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/LuaSnip' }

        -- keymap
        vim.keymap.set('i', '<C-l>', function()
            if luasnip.expandable() then
                luasnip.expand()
            end
        end, { desc = 'LuaSnip Expand' })

        vim.keymap.set({ 'i', 's' }, '<C-j>', function()
            if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            end
        end, { desc = 'LuaSnip Forward Jump' })

        vim.keymap.set({ 'i', 's' }, '<C-k>', function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { desc = 'LuaSnip Backward Jump' })

        vim.keymap.set('i', '<C-e>', function()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end, { desc = 'LuaSnip Next Choice' })
    end
end

return M
