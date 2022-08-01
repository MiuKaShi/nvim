local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').ltex.setup {
        cmd = { '/usr/bin/ltex-ls' },
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {'pandoc', 'tex' },
        settings = {
            ltex = {
                language = 'en-US',
                sentenceCacheSize = 2000,
                dictionary = {
                    -- Couldn't make this work, unfortunately, so added `MORFOLOGIK_RULE_EN_US`.
                    ['en-US'] = { [[:~/.config/nvim/spell/en.utf-8.add]] },
                },
                additionalRules = { motherTongue = 'en' },
                disabledRules = {
                    ['en-US'] = { 'WHITESPACE_RULE', 'MORFOLOGIK_RULE_EN_US' },
                },
                markdown = {
                    nodes = {
                        CodeBlock = 'ignore',
                        FencedCodeBlock = 'ignore',
                        AutoLink = 'dummy',
                        Code = 'dummy',
                    },
                },
            },
        },
    }
end

return M
