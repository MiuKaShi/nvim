local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').pyright.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = 'off',
                },
            },
        },
    }
end

return M
