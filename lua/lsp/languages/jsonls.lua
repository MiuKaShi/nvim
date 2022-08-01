local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').jsonls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'vscode-json-languageserver', '--stdio' },
        settings = {
            json = {
                format = { enable = false },
                schemaDownload = { enable = true },
                schemas = {
                    {
                        description = 'AWS IAM configuration',
                        fileMatch = { 'iam/*.json' },
                        url = 'https://gist.githubusercontent.com/jstewmon/ee5d4b7ec0d8d60cbc303cb515272f8a/raw/fc6977788b85ea52e9acad0347287516157b5865/aws-iam-poilcy-schema.json',
                    },
                },
            },
        },
    }
end

return M
