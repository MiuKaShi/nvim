return {
  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
  -- icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = function()
      return {
        override = {
          Dockerfile = { icon = "", color = "#b8b5ff", name = "Dockerfile" },
          css = { icon = "", color = "#61afef", name = "css" },
          deb = { icon = "", color = "#a3b8ef", name = "deb" },
          html = { icon = "", color = "#DE8C92", name = "html" },
          jpeg = { icon = " ", color = "#BD77DC", name = "jpeg" },
          jpg = { icon = " ", color = "#BD77DC", name = "jpg" },
          js = { icon = "", color = "#EBCB8B", name = "js" },
          kt = { icon = "󱈙", color = "#ffcb91", name = "kt" },
          lock = { icon = "", color = "#DE6B74", name = "lock" },
          md = { icon = "", color = "#b8b5ff", name = "mp3" },
          mp3 = { icon = "", color = "#C8CCD4", name = "mp3" },
          mp4 = { icon = "", color = "#C8CCD4", name = "mp4" },
          out = { icon = "", color = "#C8CCD4", name = "out" },
          png = { icon = " ", color = "#BD77DC", name = "png" },
          py = { icon = "", color = "#a7c5eb", name = "py" },
          rb = { icon = "", color = "#ff75a0", name = "rb" },
          rpm = { icon = "", color = "#fca2aa", name = "rpm" },
          toml = { icon = "", color = "#61afef", name = "toml" },
          ts = { icon = "ﯤ", color = "#519ABA", name = "ts" },
          vue = { icon = "﵂", color = "#7eca9c", name = "vue" },
          xz = { icon = "", color = "#EBCB8B", name = "xz" },
          yaml = { icon = "", color = "#EBCB8B", name = "xz" },
          zip = { icon = "", color = "#EBCB8B", name = "zip" },
					applescript = { icon = "", color = "#7f7f7f", name = "Applescript" },
					bib = { icon = "", color = "#6e9b2a", name = "BibTeX" },
					http = { icon = "󰴚", name = "HTTP request" }, -- for rest.nvim
					noice = { icon = "󰎟", name = "noice.nvim" },
					lazy = { icon = "󰒲", name = "lazy.nvim" },
					mason = { icon = "", name = "mason.nvim" },
					octo = { icon = "", name = "octo.nvim" },
					TelescopePrompt = { icon = "", name = "Telescope" },
        },
      }
    end,
  },

  {
    "shellRaining/hlchunk.nvim",
    event = "BufReadPost",
    opts = function()
      local langs = {
        help = true,
        aerial = true,
        alpha = true,
        dashboard = true,
        packer = true,
        Trouble = true,
        lspinfo = true,
        terminal = true,
        checkhealth = true,
        man = true,
        mason = true,
        NvimTree = true,
        ["neo-tree"] = true,
        plugin = true,
        lazy = true,
        TelescopePrompt = true,
        markdown = false,
        ["markdown.pandoc"] = false,
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
    "echasnovski/mini.trailspace",
    event = "VeryLazy",
    config = true,
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
          disabled_filetypes = {
            winbar = {},
            statusline = { "alpha", "dashboard" },
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
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
            { function() return vim.opt.spell:get() and "[SPELL]" or "" end },
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
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function() return "󱑍 " .. os.date "%R" end,
          },
        },
        extensions = {},
      }
    end,
  },

  -- Enhanced matchparen
  {
    "utilyre/sentiment.nvim",
    event = "VeryLazy",
    opts = {
      included_buftypes = {
        [""] = true,
      },
      excluded_filetypes = {},
      delay = 50,
      limit = 100,
      pairs = {
        { "(", ")" },
        { "{", "}" },
        { "[", "]" },
      },
    },
  },

  -- Enhanced search count
  {
    "kevinhwang91/nvim-hlslens",
    keys = {
      { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { "*", [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { "#", [[#<Cmd>lua require('hlslens').start()<CR>]] },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    },
		init = function()
      vim.cmd [[
 	 	 	 	 hi HlSearchFloat guibg=None guifg=green gui=underline
 	 	 	 	 hi HlSearchLensNear guibg=None guifg=red gui=italic
 	 	 	 	 hi HlSearchLens guibg=None guifg=green gui=underline
			]]
		end,
		opts = {
			nearest_only = true,
			-- format virtual text
			override_lens = function(render, posList, nearest, idx, _)
				local lnum, col = unpack(posList[idx])
				local text = ("%d/%d"):format(idx, #posList)
				local chunks = {
					{ " ", "Ignore" }, -- = padding
					{ "👉 ", "HLSearchReversed" },
					{ text, "HlSearchLensNear" },
					{ " 👈", "HLSearchReversed" },
				}
				render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
			end,
		},
  },
  -- emphasized undo/redos
  {
    "tzachar/highlight-undo.nvim",
    event = "VeryLazy",
    keys = { "u", "U" },
    opts = {
      duration = 250,
      keymaps = {
        { "n", "u", "silent undo", { desc = "󰕌 Undo", silent = true } },
        { "n", "U", "silent redo", { desc = "󰑎 Redo", silent = true } },
      },
    },
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },

  -- prompt ui
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    event = "VeryLazy",
    init = function()
			-- stylua: ignore
			vim.keymap.set("n", "<Esc>", function() vim.cmd.Noice("dismiss") end, { desc = "󰎟 Clear Notifications" })
    end,
    opts = {
      routes = {
        { filter = { event = "msg_show", find = "B written$" }, view = "mini" },
        -- nvim-early-retirement
        { filter = { event = "notify", find = "^Auto%-Closing Buffer:" }, view = "mini" },
        -- nvim-treesitter
        { filter = { event = "msg_show", find = "^%[nvim%-treesitter%]" }, view = "mini" },
        -- unneeded info on search patterns
        { filter = { event = "msg_show", find = "^/." }, skip = true },
        { filter = { event = "msg_show", find = "^?." }, skip = true },
        { filter = { event = "msg_show", find = "^E486: Pattern not found" }, view = "mini" },
        -- redirect to split
        { filter = { event = "msg_show", min_height = 10 }, view = "split" },
      },
      cmdline = {
        view = "cmdline",
        format = {
          search_down = { icon = "  " },
          cmdline = { icon = " " },
          IncRename = {
            pattern = "^:IncRename ",
            icon = " ",
            conceal = true,
            opts = {
              border = { style = "single" },
              relative = "cursor",
              size = { width = 30 }, -- `max_width` does not work, so fixed value
              position = { row = -3, col = 0 },
            },
          },
        },
      },
      views = {
        mini = { timeout = 3000 },
        hover = {
          border = { style = "single" },
          size = { max_width = 80 },
          win_options = { scrolloff = 4 },
        },
        split = {
          enter = true,
          size = "40%",
          close = { keys = { "q" } },
          win_options = { scrolloff = 2 },
        },
      },
      commands = {
        history = {
          view = "split",
          filter_opts = { reverse = true }, -- show newest entries first
          opts = { enter = true },
        },
      },

      -- DISABLED, since conflicts with existing plugins I prefer to use
      popupmenu = { backend = "cmp" }, -- replace with nvim-cmp, since more sources
      messages = { view_search = false }, -- replaced by nvim-hlslens
      lsp = {
        progress = { enabled = false }, -- replaced with nvim-dr-lsp, since this one cannot filter null-ls
        signature = { enabled = false }, -- replaced with lsp_signature.nvim

        -- ENABLED features
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
    },
  },
  -- Notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "minimal", -- minimal|default|compact
      top_down = false,
      max_width = 70,
      max_height = 10,
      minimum_width = 15,
      level = 0, -- minimum severity level to display (0 = display all)
      timeout = 1500,
      stages = "static",
      on_open = function(win)
        if not vim.api.nvim_win_is_valid(win) then return end
        vim.api.nvim_win_set_config(win, { border = "single" })
      end,
    },
    init = function()
      -- copy [l]ast [n]otice
      vim.keymap.set("n", "<leader>ln", function()
        local history = require("notify").history()
        if #history == 0 then
          vim.notify("No Notification in this session.", vim.log.levels.WARN)
          return
        end
        local msg = history[#history].message
        vim.fn.setreg("+", msg)
        vim.notify("Last Notification copied.", vim.log.levels.TRACE)
      end, { desc = "󰎟 Copy Last Notification" })
    end,
  },
}
