local settings = { Lua = {
    runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
    },
    diagnostics = { globals = { 'vim', 'use' } } } }

local M = {}

M.setup = function(on_attach, capabilities)
    local luadev = require('lua-dev').setup {
        cmd = {
            'lua-language-server',
            '-E',
            '/usr/lib/lua-language-server/main.lua',
        },
        lspconfig = {
            commands = {
                Format = {
                    function()
                        require('stylua-nvim').format_file()
                    end,
                },
            },
            on_attach = on_attach,
            capabilities = capabilities,
            settings = settings,
        },
    }
    require('lspconfig').sumneko_lua.setup(luadev)
end

return M
