local status_cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_cmp_ok then
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.offsetEncoding = { 'utf-16' }
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local signs = {
    { name = 'DiagnosticSignError', text = '🔥' },
    { name = 'DiagnosticSignWarn', text = '💩' },
    { name = 'DiagnosticSignHint', text = '💡' },
    { name = 'DiagnosticSignInfo', text = '💬' },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(
        sign.name,
        { texthl = sign.name, text = sign.text, numhl = '' }
    )
end

local on_attach = function(client, bufnr)
    vim.keymap.set(
        'n',
        'gD',
        vim.lsp.buf.declaration,
        { buffer = bufnr, desc = 'Go to Declaration' }
    )

    vim.keymap.set(
        'n',
        'gi',
        vim.lsp.buf.implementation,
        { buffer = bufnr, desc = 'Go to Implementation' }
    )

    local tb = require 'telescope.builtin'
    local themes = require 'telescope.themes'

    vim.keymap.set('n', 'gd', function()
        tb.lsp_definitions(themes.get_dropdown {})
    end, { buffer = bufnr, desc = 'Go to Definitions' })

    local caps = client.server_capabilities
    if caps.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
        vim.api.nvim_clear_autocmds {
            buffer = bufnr,
            group = 'lsp_document_highlight',
        }
        vim.api.nvim_create_autocmd('CursorHold', {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = 'lsp_document_highlight',
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = 'lsp_document_highlight',
        })
    end

    if caps.codeActionProvider then
        vim.keymap.set(
            { 'n', 'v' },
            '<leader>ca',
			function()
				require('lspsaga.codeaction'):code_action()
			end,
            { buffer = bufnr, desc = '(Range) Code Actions' }
        )
    end

    if caps.documentFormattingProvider then
        vim.keymap.set('n', '<leader>bf', function()
            vim.lsp.buf.format { async = true }
        end, { buffer = bufnr, desc = 'Formmating' })
    end
    if caps.documentRangeFormattingProvider then
        vim.keymap.set(
            'v',
            '<leader>bf',
            vim.lsp.buf.format,
            { buffer = bufnr, desc = 'Range Formmating' }
        )
    end
end

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
    require('user.lsp.settings.' .. server).setup(on_attach, capabilities)
end

--for matlab
local matlabfmt = require 'user.lsp.efm.matlabfmt'
local languages = { matlab = { matlabfmt } }

require('lspconfig').efm.setup {
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
