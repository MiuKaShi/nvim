return {
	-- ui components
	{ "MunifTanjim/nui.nvim",        lazy = true },
	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"shellRaining/hlchunk.nvim",
		event = "VeryLazy",
		opts = function()
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
				["neo-tree"] = true,
				["markdown.pandoc"] = true,
				plugin = true,
				lazy = true,
				TelescopePrompt = true,
			}
			return {
				chunk = {
					enable = true,
					use_treesitter = true,
					notify = false,
					exclude_filetypes = langs,
					style = "#cc241d",
					chars = {
						horizontal_line = "━",
						left_top = "┏",
						vertical_line = "┃",
						left_bottom = "┗",
						right_arrow = "━",
					},
				},
				indent = {
					enable = true,
					use_treesitter = false,
					chars = { "│", "¦", "┆", "┊" },
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
				},
				line_num = {
					enable = true,
					use_treesitter = false,
					style = "#fabd2f", -- Candidate colors.
				},
				blank = {
					enable = false,
					chars = { "·" },
					style = {
						vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID "Whitespace"), "fg", "gui"),
					},
				},
			}
		end,
	},

	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = function()
			local hi = require "mini.hipatterns"
			return {
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
					hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
				},
			}
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local util = require "util"
			local icons = require("config").icons
			local theme = require("config").themes.lualine
			return {
				options = {
					theme = theme,
					icons_enabled = true,
					component_separators = "|",
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
					},
					lualine_x = {
						util.rime_status,
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
					},
					lualine_y = {
						util.getwords,
						{ "progress", separator = " ",                  padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function() return " " .. os.date "%R" end,
					},
				},
				extensions = {},
			}
		end,
	},

	-- Enhanced matchparen
	{
		"utilyre/sentiment.nvim",
		event = "BufReadPost",
		config = true,
	},

	-- File manager
	{
		"is0n/fm-nvim",
		cmd = "Lf",
		opts = {
			edit_cmd = "edit",
			ui = {
				default = "float",
				float = { border = "single", border_hl = "NONE" },
			},
			cmds = {
				-- https://gist.github.com/Provessor/dbb4a6d22945e7a42c3b904302ee273c
				lf_cmd = "~/.local/bin/lfub",
			},
		},
	},
}
