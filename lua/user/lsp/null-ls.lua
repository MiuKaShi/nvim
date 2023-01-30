local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
    formatting.prettierd.with {
        filetypes = { 'css', 'json', 'yaml', 'markdown' },
        extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
    },
    -- CMake
    formatting.cmake_format,
    -- python
    formatting.black.with { extra_args = { '--fast' } },
    -- lua
    formatting.stylua.with {
        extra_args = {
            '--config-path',
            vim.fn.expand '~/.config/stylua/stylua.toml',
        },
    },
    formatting.shfmt.with {
        extra_args = { '-i', '4', '-ci', '-bn' },
    },
    diagnostics.mlint, -- linting for MATLAB files
    diagnostics.luacheck,
    -- markdown
    diagnostics.markdownlint.with {
        args = {
            '--config',
            '~/.config/markdownlint/markdownlint.yaml',
            '--stdin',
        },
    },
    -- shell
    code_actions.shellcheck,
}

null_ls.setup {
    debug = false,
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
