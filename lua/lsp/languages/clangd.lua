local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').clangd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
            "c",
            "cpp",
            "objc",
            "objcpp",
        };
        flags = { debounce_text_changes = 150 },
    }
end

return M
