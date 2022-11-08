local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').sumneko_lua.setup {
        require('neodev').setup {
            lspconfig = {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = { globals = { 'vim', 'use' } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                            checkThirdParty = false,
                        },
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
