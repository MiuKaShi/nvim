local M = {}

M.setup = function(on_attach, capabilities)
    -- global status
    vim.g.rime_enabled = false

    -- add rime-ls to lspconfig as a custom server
    local lspconfig = require 'lspconfig'
    local configs = require 'lspconfig/configs'
    configs.rime_ls = {
        default_config = {
            name = 'rime_ls',
            cmd = { 'rime_ls' },
            filetypes = { '*' },
            single_file_support = true,
        },
        settings = {},
        docs = {
            description = [[
https://www.github.com/wlh320/rime-ls

A language server for librime
]],
        },
    }
    require('lspconfig').rime_ls.setup {
        init_options = {
            enabled = vim.g.rime_enabled,
            shared_data_dir = '/usr/share/rime-data', -- rime 公共目录
            user_data_dir = vim.fn.expand '~/.local/share/rime-ls', -- 指定用户目录, 最好新建一个
            log_dir = vim.fn.expand '~/.local/share/rime-ls/log', -- 日志目录
            max_candidates = 9, -- 与 rime 的候选数量配置最好保持一致
            trigger_characters = {}, -- 为空表示全局开启
        },
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

function M.setup()
    local start_rime = function()
        local client_id = vim.lsp.start_client {
            name = 'rime-ls',
            cmd = { '/home/miuka/.local/bin/rime_ls' },
        }
        vim.lsp.buf_attach_client(0, client_id)
        if client_id then
            vim.lsp.buf_attach_client(0, client_id)
            -- 快捷键手动开启
            vim.keymap.set('n', '<leader><Space>', function()
                vim.lsp.buf.execute_command { command = 'rime-ls.toggle-rime' }
            end)
            vim.keymap.set('n', '<leader>rs', function()
                vim.lsp.buf.execute_command { command = 'rime-ls.sync-user-data' }
            end)
        end
    end
    -- 对每个文件都默认开启
    vim.api.nvim_create_autocmd('BufReadPost', {
        pattern = '*',
        callback = function()
            start_rime()
        end,
    })
end

return M
