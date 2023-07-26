local fn, lsp = vim.fn, vim.lsp

return {

	-- lspconfig
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'folke/neodev.nvim', config = true },
			'hrsh7th/cmp-nvim-lsp',
		},
		config = function()
			-- diagnostics signs
			local icons = require('config').icons.diagnostics
			for name, icon in pairs(icons) do
				name = 'DiagnosticSign' .. name
				fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
			end

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

			-- diagnostics config
			vim.diagnostic.config {
				virtual_text = { spacing = 4, prefix = '●' },
				severity_sort = true,
			}

			-- lspconfig
			local capabilities = require('cmp_nvim_lsp').default_capabilities(lsp.protocol.make_client_capabilities())

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
				require('plugins.lsp.servers.' .. server).setup(on_attach, capabilities)
			end

			-- rime_ls server
			require 'plugins.lsp.servers.rimels'
		end,
		event = { 'BufReadPre', 'BufNewFile' },
	},

	-- inject LSP
	{
		'jose-elias-alvarez/null-ls.nvim',
		config = function()
			local null_ls = require 'null-ls'
			local helpers = require 'null-ls.helpers'
			local methods = require 'null-ls.methods'
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local mh_style = {
				name = 'mh_style',
				meta = {
					url = 'https://github.com/florianschanda/miss_hit',
					description = 'formatter for matlab',
				},
				method = methods.internal.FORMATTING,
				filetypes = { 'matlab' },
				generator_opts = {
					command = '/home/miuka/.local/bin/mh_style',
					args = { '--input-encoding=utf-8', '--fix', '$FILENAME' },
					to_temp_file = true,
				},
				factory = helpers.formatter_factory,
			}

			local sources = {
				--formatter
				-- css json markdown yaml
				formatting.prettierd.with {
					filetypes = { 'css', 'json', 'yaml', 'markdown' },
				},
				-- c
				formatting.astyle.with {
					filetypes = { 'c' },
					extra_args = {
						'--mode=c',
						'--indent=spaces=4',
						'--convert-tabs',
						'--pad-oper',
						'--indent-col1-comments',
						'--unpad-paren',
						'--max-code-length=120',
						'--add-one-line-brackets',
						'--style=linux',
						'--indent-classes',
						'--keep-one-line-statements',
						'--add-brackets',
						'--pad-header',
						'--break-blocks',
						'--indent=spaces=4',
						'--convert-tabs',
						'--break-after-logical',
						'--min-conditional-indent=2',
						'--max-instatement-indent=40',
						'--keep-one-line-blocks',
					},
				},
				-- Latex
				formatting.latexindent,
				-- CMake
				formatting.cmake_format,
				-- Fortran
				formatting.fprettify.with {
					extra_args = {
						'--indent',
						'4',
						'--whitespace',
						'3',
						'--strict-indent',
						'--enable-decl',
						'--case',
						'1',
						'1',
						'1',
						'0',
					},
				},
				-- python
				formatting.black.with { extra_args = { '--fast' } },
				-- lua
				formatting.stylua.with {
					extra_args = { '--config-path', vim.fn.expand '~/.config/stylua/stylua.toml' },
				},
				formatting.shfmt.with {
					extra_args = { '-i', '4', '-ci', '-bn' },
				},

				--diagnostics
				-- MATLAB
				diagnostics.mlint,
				helpers.make_builtin(mh_style),
				-- markdown
				diagnostics.markdownlint.with {
					args = {
						'--config',
						'~/.config/markdownlint/markdownlint.yaml',
						'--stdin',
					},
				},
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
		end,
		event = { 'BufReadPre', 'BufNewFile' },
	},

	-- lsp enhancement
	{
		'nvimdev/lspsaga.nvim',
		opts = {
			symbol_in_winbar = {
				enable = false,
			},
			lightbulb = {
				enable = false,
			},
			ui = {
				theme = 'round',
				winblend = 0,
				title = false,
				border = 'single',
				expand = '',
				collapse = '',
				colors = {
					normal_bg = 'none',
					title_bg = 'none',
					red = '#ea6962',
					magenta = '#98869a',
					orange = '#e78a4e',
					yellow = '#d8a657',
					green = '#a9b665',
					cyan = '#89b482',
					blue = '#7daea3',
					purple = '#d3869b',
					white = '#d1d4cf',
					black = '#1e2030',
				},
				scroll_preview = {
					scroll_down = '<C-9>',
					scroll_up = '<C-0>',
				},
			},
		},
		cmd = 'Lspsaga',
		-- stylua: ignore
		keys = {
			{ "gh", function() require("lspsaga.finder"):new({}) end, silent = true, desc = "Lsp Finder" }
		},
	},
	{
		'folke/trouble.nvim',
		opts = {
			position = 'bottom',
			signs = {
				error = '🔥',
				warning = '💩',
				hint = '💡',
				information = '💬',
				other = '📌',
			},
			use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
		},
		cmd = 'TroubleToggle',
		keys = {
			{
				'<leader>xx',
				function()
					require('trouble').toggle()
				end,
				desc = 'Trouble',
			},
		},
	},
}
