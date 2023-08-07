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

  -- Enhanced search
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
    config = function()
      vim.cmd [[
 	 	 	 	 hi HlSearchFloat guibg=None guifg=green gui=underline
 	 	 	 	 hi HlSearchLensNear guibg=None guifg=red gui=italic
 	 	 	 	 hi HlSearchLens guibg=None guifg=green gui=underline
			]]
      require("hlslens").setup()
    end,
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },
}
