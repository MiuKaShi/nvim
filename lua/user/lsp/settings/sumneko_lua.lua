local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').sumneko_lua.setup {
        require('neodev').setup {
            cmd = {
                'lua-language-server',
                '-E',
                '/usr/lib/lua-language-server/main.lua',
            },
            lspconfig = {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            path = vim.split(package.path, ';'),
                        },
                        diagnostics = { globals = { 'vim', 'use' } },
                        telemetry = { enable = false },
                        hint = {
                            enable = true,
                            settype = true,
                        },
                    },
                },
            },
        },
    }
end

return M
