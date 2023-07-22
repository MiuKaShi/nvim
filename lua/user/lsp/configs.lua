-- Mappings
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local bufopts = { buffer = bufnr }
        vim.keymap.set('n', 'J', '<cmd>Lspsaga peek_definition<CR>', bufopts) -- 预览定义
        vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', bufopts) -- 显示文档定义
        vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>', bufopts) -- 重命名变量
        vim.keymap.set('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<CR>', bufopts) -- 诊断问题
        vim.keymap.set('n', 'gh', '<cmd>Lspsaga finder ref<CR>', bufopts) -- 查找变量名
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', bufopts)
        vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', bufopts) -- 滚动hover 上
        vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', bufopts) -- 滚动hover 下
    end,
})

local function lsp_highlight(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'lsp_document_highlight' }
        vim.api.nvim_create_autocmd(
            'CursorHold',
            { callback = vim.lsp.buf.document_highlight, buffer = bufnr, group = 'lsp_document_highlight' }
        )
        vim.api.nvim_create_autocmd(
            'CursorMoved',
            { callback = vim.lsp.buf.clear_references, buffer = bufnr, group = 'lsp_document_highlight' }
        )
    end
end

local function lsp_formatting(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set('n', '<leader>bf', function()
            vim.lsp.buf.format { async = true }
        end, { buffer = bufnr, desc = 'Formmating' })
    end
    if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set('v', '<leader>bf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Range Formmating' })
    end
end

-- icons config
local signs = {
    { name = 'DiagnosticSignError', text = '😱' },
    { name = 'DiagnosticSignWarn', text = '⚠' },
    { name = 'DiagnosticSignHint', text = '🔰' },
    { name = 'DiagnosticSignInfo', text = '👀' },
}
for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

-- diagnostics config
vim.diagnostic.config {
    virtual_text = { spacing = 4, prefix = '●' },
    severity_sort = true,
}

-- lsp func setting
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { 'utf-16' }
local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if status_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local on_attach = function(client, bufnr)
    lsp_highlight(client, bufnr)
    lsp_formatting(client, bufnr)
end

for _, server in ipairs {
    'pyright',
    'clangd',
    'cssls',
    'gopls',
    'jsonls',
    'htmls',
    'yamlls',
    'bashls',
    'vimls',
    'luals',
    'fortls',
    'julials',
    'texlab',
} do
    require('user.lsp.settings.' .. server).setup(on_attach, capabilities)
end

-- rime_ls server
require 'user.lsp.settings.rimels'
