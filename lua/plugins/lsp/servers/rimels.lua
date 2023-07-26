-- rime_ls enable
vim.g.rime_enabled = false

-- add rime-ls to lspconfig as a custom server
local configs = require 'lspconfig.configs'

if not configs.rime_ls then
	configs.rime_ls = {
		default_config = {
			name = 'rime_ls',
			cmd = { 'rime_ls' },
			-- cmd = vim.lsp.rpc.connect('127.0.0.1', 9257),
			filetypes = { 'markdown.pandoc', 'tex', 'matlab' },
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
end

local rime_on_attach = function(client, _)
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
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- rime_ls setup
require('lspconfig').rime_ls.setup {
	init_options = {
		enabled = vim.g.rime_enabled,
		shared_data_dir = '/usr/share/rime-data',               -- rime 公共目录
		user_data_dir = vim.fn.expand '~/.local/share/rime-ls', -- 指定用户目录, 最好新建一个
		log_dir = vim.fn.expand '~/.local/share/rime-ls/log',   -- 日志目录
		trigger_characters = {},                                -- 为空表示全局开启
		always_incomplete = false,                              -- [since v0.2.3] true 强制补全永远刷新整个列表，而不是使用过滤
		max_tokens = 0,                                         -- [since v0.2.3] 大于 0 表示会在删除到这个字符个数的时候，重建所有候选词，而不使用删除字符操作
		preselect_first = true,                                 --是否默认第一个候选项是选中状态，default false
		schema_trigger_character = '&',                         -- 当输入此字符串时请求补全会触发 “方案选单”
	},
	on_attach = rime_on_attach,
	capabilities = capabilities,
}
