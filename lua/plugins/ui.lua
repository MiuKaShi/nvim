return {
	{ 'MunifTanjim/nui.nvim' },
	{ 'nvim-tree/nvim-web-devicons' },

	{
		'shellRaining/hlchunk.nvim',
		event = { 'BufReadPost', 'BufNewFile' },
		config = function()
			local hlchunk = require 'hlchunk'
			local langs = {
				help = true,
				aerial = true,
				alpha = true,
				dashboard = true,
				packer = true,
				Trouble = true,
				lspinfo = true,
				markdown = true,
				terminal = true,
				checkhealth = true,
				man = true,
				mason = true,
				NvimTree = true,
				['neo-tree'] = true,
				['markdown.pandoc'] = true,
				plugin = true,
				lazy = true,
				TelescopePrompt = true,
				[''] = true, -- because TelescopePrompt will set a empty ft, so add this.
			}
			hlchunk.setup {
				chunk = {
					enable = true,
					use_treesitter = true,
					notify = false,
					exclude_filetypes = langs,
					style = '#cc241d',
					chars = {
						horizontal_line = '━',
						left_top = '┏',
						vertical_line = '┃',
						left_bottom = '┗',
						right_arrow = '━',
					},
				},
				indent = {
					enable = true,
					use_treesitter = false,
					exclude_filetypes = {
						lua = true,
						sh = true,
						python = true,
						c = true,
						cpp = true,
						diff = true,
						yaml = true,
						json = true,
					},
					chars = { '│', '¦', '┆', '┊' },
				},
				line_num = {
					enable = true,
					use_treesitter = false,
					style = '#fabd2f', -- Candidate colors.
				},
				blank = {
					enable = false,
					chars = { '·' },
					style = {
						vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID 'Whitespace'), 'fg', 'gui'),
					},
				},
			}
		end,
	},

	{
		'echasnovski/mini.hipatterns',
		event = 'BufReadPre',
		config = function()
			local hipatterns = require 'mini.hipatterns'
			hipatterns.setup {
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
					hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
					todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
					note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			}
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		config = function()
			local colors = {
				darkgray = '#282828',
				gray = '#a89984',
				innerbg = nil,
				outerbg = '#282828',
				normal = '#458588',
				insert = '#689d6a',
				visual = '#d79921',
				replace = '#cc241d',
				command = '#ebdbb2',
			}
			local gruvboxline = {
				inactive = {
					a = { fg = colors.gray, bg = colors.outerbg, gui = 'bold' },
					b = { fg = colors.gray, bg = colors.outerbg },
					c = { fg = colors.gray, bg = colors.innerbg },
				},
				visual = {
					a = { fg = colors.darkgray, bg = colors.visual, gui = 'bold' },
					b = { fg = colors.gray, bg = colors.outerbg },
					c = { fg = colors.gray, bg = colors.innerbg },
				},
				replace = {
					a = { fg = colors.darkgray, bg = colors.replace, gui = 'bold' },
					b = { fg = colors.gray, bg = colors.outerbg },
					c = { fg = colors.gray, bg = colors.innerbg },
				},
				normal = {
					a = { fg = colors.darkgray, bg = colors.normal, gui = 'bold' },
					b = { fg = colors.gray, bg = colors.outerbg },
					c = { fg = colors.gray, bg = colors.innerbg },
				},
				insert = {
					a = { fg = colors.darkgray, bg = colors.insert, gui = 'bold' },
					b = { fg = colors.gray, bg = colors.outerbg },
					c = { fg = colors.gray, bg = colors.innerbg },
				},
				command = {
					a = { fg = colors.darkgray, bg = colors.command, gui = 'bold' },
					b = { fg = colors.gray, bg = colors.outerbg },
					c = { fg = colors.gray, bg = colors.innerbg },
				},
			}
			-- rime_status
			local function rime_status()
				if vim.g.rime_enabled then
					return 'CN'
				else
					return 'EN'
				end
			end
			local diff = {
				'diff',
				symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
			}
			local diagnostics = {
				'diagnostics',
				symbols = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }, -- changes diff symbols
			}
			local getWords = {
				'getWords',
				fmt = function()
					if vim.bo.filetype == 'md' or vim.bo.filetype == 'text' or vim.bo.filetype == 'markdown.pandoc' then
						if vim.fn.wordcount().visual_words == nil then
							return tostring(vim.fn.wordcount().words)
						end
						return tostring(vim.fn.wordcount().visual_words)
					else
						return ''
					end
				end,
				padding = 1,
				color = { fg = colors.orange2 },
			}
			local lualine = require 'lualine'
			lualine.setup {
				options = {
					theme = gruvboxline,
					icons_enabled = true,
					component_separators = '|',
					section_separators = { left = '', right = '' },
				},
				sections = {
					lualine_a = { { 'mode', right_padding = 2 } },
					lualine_b = { 'branch' },
					lualine_c = {
						diagnostics,
						{ 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
						{ 'filename', path = 1, symbols = { modified = '  ', readonly = '', unnamed = '' } },
					},
					lualine_x = {
						rime_status,
						diff,
					},

					lualine_y = {
						getWords,
						{ 'progress', separator = ' ',                  padding = { left = 1, right = 0 } },
						{ 'location', padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return ' ' .. os.date '%R'
						end,
					},
				},
				extensions = {},
			}
		end,
	},

	-- Enhanced matchparen
	{
		'utilyre/sentiment.nvim',
		event = 'BufReadPost',
		config = true,
	},

	-- File manager
	{
		'is0n/fm-nvim',
		cmd = 'Lf',
		opts = {
			edit_cmd = 'edit',
			ui = {
				default = 'float',
				float = { border = 'single', border_hl = 'NONE' },
			},
			cmds = {
				-- https://gist.github.com/Provessor/dbb4a6d22945e7a42c3b904302ee273c
				lf_cmd = '~/.local/bin/lfub',
			},
		},
	},
}
