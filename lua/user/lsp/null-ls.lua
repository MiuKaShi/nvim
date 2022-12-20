local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
    return
end

local b = null_ls.builtins

local sources = {
    b.formatting.prettierd.with {
        filetypes = { 'html', 'json', 'yaml', 'markdown' },
        extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
    },
    -- CMake
    b.formatting.cmake_format,
    -- python
    b.formatting.black.with { extra_args = { '--fast' } },
    -- lua
    b.formatting.stylua.with {
        extra_args = {
            '--config-path',
            vim.fn.expand '~/.config/stylua/stylua.toml',
        },
    },
    b.diagnostics.luacheck,
    -- markdown
    b.diagnostics.markdownlint.with {
        args = {
            '--config',
            '~/.config/markdownlint/markdownlint.yaml',
            '--stdin',
        },
    },
    -- shell
    b.code_actions.shellcheck,
    b.formatting.shfmt.with {
        extra_args = { '-i', '4', '-ci', '-bn' },
    },
}

null_ls.setup {
    sources = sources,
    on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
            vim.keymap.set('n', '<leader>bf', function()
                vim.lsp.buf.format { async = true }
            end, { buffer = bufnr, desc = 'Formmating' })
        end
        if client.server_capabilities.documentRangeFormattingProvider then
            vim.keymap.set('v', '<leader>bf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Range Formmating' })
        end
    end,
}
