return {

	-- auto pairs
	{
		"altermo/ultimate-autopair.nvim",
		config = true,
		event = { "InsertEnter" },
	},
	-- surround
	{
		"kylechui/nvim-surround",
		config = true,
		keys = { "cs", "ds", "ys", "yS" },
	},

	-- symbols outline
	{
		"stevearc/aerial.nvim",
		opts = {
			backends = { "lsp", "treesitter", "markdown", "man" },
			filter_kind = false,
			show_guides = true,
			layout = { min_width = 30, default_direction = "left" },
		},
		cmd = "AerialToggle",
		-- stylua: ignore
		keys = { { "<leader>o", function() require("aerial").toggle() end, desc = "Aerial" } },
	},

	-- diffview
	{
		"sindrets/diffview.nvim",
		opts = { enhanced_diff_hl = true },
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		-- stylua: ignore
		keys = { { "<leader>gd", function() require("diffview").open({}) end, desc = "Diff View" } },
	},

	-- Navigate with search labels
	{
		"folke/flash.nvim",
		opts = {
			labels = "asdfghjklqwertyuiopzxcvbnm",
			highlight = {
				backdrop = false,
				matches = true,
				priority = 5000,
			},
			modes = {
				char = {
					enabled = false,
				},
				treesitter_search = {
					label = { before = true, after = true, style = "inline" },
					highlight = {
						backdrop = false,
						matches = false,
					},
				},
			},
		},
		-- stylua: ignore
		keys = {
			"f", "F", "t", "T", ";", ",",
			{ "s", mode = { "n", "o", "x" }, function() require("flash").jump() end,       desc = "Flash" },
			{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		},
	},

	-- align
	{
		"Vonr/align.nvim",
		keys = {
			{
				"aa",
				mode = { "x" },
				function() require("align").align_to_char(1, true) end,
				silent = true,
			},
			{
				"as",
				mode = { "x" },
				function() require("align").align_to_char(2, true, true) end,
				silent = true,
			},
			{
				"aw",
				mode = { "x" },
				function() require("align").align_to_string(false, true, true) end,
				silent = true,
			},
			{
				"ar",
				mode = { "x" },
				function() require("align").align_to_string(true, true, true) end,
				silent = true,
			},
		},
	},

	-- comment
	{
		"echasnovski/mini.comment",
		config = true,
		keys = {
			"gcc",
			{ "gbc", mode = { "n", "x" } },
			{ "gc",  mode = { "n", "x" } },
		},
	},

	-- highlight words
	{
		"dwrdx/mywords.nvim",
		event = { "InsertEnter" },
		keys = {
			{
				"<leader>hh",
				function() require("mywords").hl_toggle() end,
				silent = true,
				desc = "highlight words",
			},
			{
				"<leader>hx",
				function() require("mywords").uhl_all() end,
				silent = true,
				desc = "unhighlight words",
			},
		},
	},

	-- github copilot
	{
		"zbirenbaum/copilot.lua",
		build = ":Copilot auth",
		cmd = "Copilot",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-y>",
					close = "<Esc>",
					next = "<C-z>",
					prev = "<C-x>",
					select = "<CR>",
					dismiss = "<C-c>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				c = false,
				cpp = false,
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
		},
	},

	-- GPT
	{
		"james1236/backseat.nvim",
		cmd = {
			"Backseat",
			"BackseatAsk",
			"BackseatClear",
		},
		config = function()
			vim.g.backseat_openai_api_key = ""
			vim.g.backseat_openai_model_id = "gpt-3.5-turbo"
			vim.g.backseat_language = "chinese"
			vim.keymap.set("n", "<leader>ba", ":Backseat<CR>")      -- auto comments
			vim.keymap.set("n", "<leader>bx", ":BackseatClear<CR>") -- clean comments
		end,
	},

	-- search/replace in multiple files
	{
		"windwp/nvim-spectre",
		cmd = { "Spectre" },
		opts = { open_cmd = "noswapfile vnew" },
	},
	{
		"AckslD/muren.nvim",
		config = true,
		cmd = { "MurenToggle", "MurenFresh", "MurenUnique" },
	},

	-- word
	{
		"Avi-D-coder/fzf-wordnet.vim",
		dependencies = {
			"junegunn/fzf.vim",
		},
		config = function() vim.g.fzf_wordnet_preview_arg = "" end,
		keys = {
			{ "<C-d>", "<Plug>(fzf-complete-wordnet)", mode = { "i" } },
		},
	},
	-- bib
	{
		"MiuKaShi/bibtexcite.vim",
		cmd = {
			"BibtexciteInsert",
			"BibtexciteShowcite",
			"BibtexciteOpenfile",
			"BibtexciteEditfile",
			"BibtexciteNote",
		},
		config = function()
			vim.g.bibtexcite_bibfile = "~/papers/bib/mybib.bib"
			vim.g.bibtexcite_floating_window_border = { "│", "─", "╭", "╮", "╯", "╰" }
			vim.g.bibtexcite_close_preview_on_insert = 1
		end,
		keys = {
			{ "<leader>bo", "<CMD>BibtexciteOpenfile<CR>" }, -- Bib Open pdf
			{ "<leader>bv", "<CMD>BibtexciteShowcite<CR>" }, -- Bib citation show
			{ "<leader>be", "<CMD>BibtexciteEdit<CR>" },     -- Bib citation edit
			{ "<leader>bn", "<CMD>BibtexciteNote<CR>" },     -- Bib citation note
		},
	},

	-- markdown
	{ "vim-pandoc/vim-pandoc-syntax", ft = "markdown.pandoc" }, -- markdown 高亮
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreview" },
		ft = { "markdown" },
		build = "cd app && npm install",
		config = function()
			vim.cmd [[
function! g:Open_browser(url)
    execute "silent" "!surf" a:url "&"
endfunction
]]
			vim.g.mkdp_browserfunc = "g:Open_browser"
			vim.g.mkdp_markdown_css = "/home/miuka/.config/nvim/markdown.css"
			-- vim.g.mkdp_highlight_css = '/home/miuka/.cache/wal/colors'
			vim.g.mkdp_page_title = "${name}.md"
			vim.g.mkdp_preview_options = {
				mkit = {},
				katex = {},
				uml = {},
				maid = {},
				disable_sync_scroll = 0,
				sync_scroll_type = "middle",
				hide_yaml_meta = 1,
				sequence_diagrams = {},
				flowchart_diagrams = {},
				disable_filename = 0,
			}
		end,
	},
	-- obsidian
	{
		"epwalsh/obsidian.nvim",
		cmd = {
			"ObsidianFollowLink",
			"ObsidianLink",
			"ObsidianLinkNew",
			"ObsidianQuickSwitch",
			"ObsidianSearch",
			"ObsidianBacklinks",
			"ObsidianOpen",
			"ObsidianNew",
			"ObsidianLinkNew",
		},
		opts = {
			dir = "~/notes",
			completion = {
				nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
			},
			notes_subdir = "day_notes",
			note_id_func = function(title)
				local suffix = tostring(os.date "%Y%m%d%H%M%S")
				return suffix
			end,
		},
		keys = {
			{ "<leader>nj", "<CMD>ObsidianFollowLink<CR>", desc = "[O]bsidian [F]ollow [L]ink" },
			{ "<leader>nk", "<CMD>ObsidianBacklinks<CR>",  desc = "[O]bsidian [B]acklinks" },
			{ "<leader>no", "<CMD>ObsidianOpen<CR>",       desc = "[O]bsidian [O]pen" },
			{ "<leader>ns", "<CMD>ObsidianSearch<CR>",     desc = "[O]bsidian [S]earch" },
			{ "<leader>nn", "<CMD>ObsidianNew<CR>",        desc = "[O]bsidian [N]ew" },
		},
	},
}
