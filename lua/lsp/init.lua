-- Snippets support
local lspconfig = require 'lspconfig'

-- Diagnostics symbols for display in the sign column.
local signs = { Error = '🔥', Warn = '💩', Info = '💬', Hint = '💡' }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function(client, bufnr)

    local tb = require 'telescope.builtin'
    local themes = require 'telescope.themes'

    vim.keymap.set('n', 'gd', function()
        tb.lsp_definitions(themes.get_dropdown {})
    end, { buffer = bufnr, desc = 'Go to Definitions' })

    vim.keymap.set('n', 'gl', function()
        tb.lsp_references(themes.get_dropdown {})
    end, { buffer = bufnr, desc = 'Go to References' })

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight',
        })
        vim.api.nvim_create_autocmd('CursorHold', {
            callback = vim.lsp.buf.document_highlight,
            buffer   = bufnr,
            group    = 'lsp_document_highlight',
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            callback = vim.lsp.buf.clear_references,
            buffer   = bufnr,
            group    = 'lsp_document_highlight',
        })
    end

    if client.server_capabilities.codeActionProvider then
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
            { buffer = bufnr, desc = '(Range) Code Actions' })
    end

    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set('n', '<leader>bf', function()
            vim.lsp.buf.format { async = true }
        end, { buffer = bufnr, desc = 'Formmating' })
    end
    if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set('v', '<leader>bf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Range Formmating' })
    end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

for _, server in ipairs {
    'pyright',
    'clangd',
    'cssls',
    'gopls',
    'jsonls',
    'htmls',
    'ltex',
    'yamlls',
    'bashls',
    'vimls',
    'julials',
    'sumneko_lua',
    'fortls',
} do
    require('lsp.languages.' .. server).setup(on_attach, capabilities)
end

-- Linters
local shfmt = require 'lsp.efm.shfmt'
local markdownfmt = require 'lsp.efm.markdownfmt'
local matlabfmt = require 'lsp.efm.matlabfmt'

local languages = { sh = { shfmt }, matlab = { matlabfmt }, markdown = { markdownfmt } }

lspconfig.efm.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = { documentFormatting = true },
    filetypes = vim.tbl_keys(languages),
    settings = {
        rootMarkers = { '.git/' },
        languages = languages,
        log_level = 1,
        log_file = '~/efm.log',
    },
}
