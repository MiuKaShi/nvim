-- Snippets support
local lspconfig = require 'lspconfig'

-- Diagnostics symbols for display in the sign column.
local signs = { Error = '🔥', Warn = '💩', Info = '💬', Hint = '💡' }
for sign, icon in pairs(signs) do
    vim.fn.sign_define('DiagnosticSign' .. sign, {
        text = icon,
        texthl = 'Diagnostic' .. sign,
        linehl = false,
        numhl = 'Diagnostic' .. sign,
    })
end

local on_attach = function(client, bufnr)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
        vim.api.nvim_clear_autocmds {
            buffer = bufnr,
            group = 'lsp_document_highlight',
        }
        vim.api.nvim_create_autocmd('CursorHold', {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = 'lsp_document_highlight',
            desc = 'Document Highlight',
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = 'lsp_document_highlight',
            desc = 'Clear All the References',
        })
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
