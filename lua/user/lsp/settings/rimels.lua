-- rime_ls enable
vim.g.rime_enabled = false

-- add rime-ls to lspconfig as a custom server
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local util = require 'lspconfig.util'

configs.rime_ls = {
    default_config = {
        name = 'rime_ls',
        cmd = { 'rime_ls' },
        filetypes = { 'markdown.pandoc', 'org', 'matlab' },
        root_dir = util.find_git_ancestor,
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

local on_attach = function(client, _)
    local toggle_rime = function()
        client.request('workspace/executeCommand', { command = 'rime-ls.toggle-rime' }, function(_, result, ctx, _)
            if ctx.client_id == client.id then
                vim.g.rime_enabled = result
            end
        end)
    end
    -- keymaps for executing command
    vim.keymap.set('n', '<leader><space>', function()
        toggle_rime()
    end)
    vim.keymap.set('i', '<C-x>', function()
        toggle_rime()
    end)
    vim.keymap.set('n', '<lsader>rs', function()
        vim.lsp.buf.execute_command { command = 'rime-ls.sync-user-data' }
    end)
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- rime_ls setup
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
