-- Installation:
-- https://github.com/josephsdavid/juliacli
local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').julials.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'juliacli', 'server' },
        settings = {
            julia = {
                usePlotPane = false,
                symbolCacheDownload = false,
                runtimeCompletions = true,
                singleFileSupport = false,
                useRevise = true,
                lint = {
                    NumThreads = 11,
                    missingrefs = 'all',
                    iter = true,
                    lazy = true,
                    modname = true,
                },
            },
        },
    }
end

return M
