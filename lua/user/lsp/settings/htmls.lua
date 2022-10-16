local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').html.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'vscode-html-languageserver', '--stdio' },
        filetypes = { 'html', 'blade' },
    }
end

return M
