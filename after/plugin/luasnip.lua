local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.setup {
    update_events = 'TextChanged,TextChangedI',
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { '<- Current Choice', 'NonText' } },
            },
        },
    },
}

require('luasnip.loaders.from_lua').lazy_load {
    paths = { '~/.config/nvim/luasnippets' },
}
