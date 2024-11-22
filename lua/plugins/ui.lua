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

  -- indent rainbow line color
  -- {
  --   "shellRaining/hlchunk.nvim",
  --   event = "BufReadPost",
  --   opts = function()
  --     local langs = {
  --       help = true,
  --       aerial = true,
  --       alpha = true,
  --       dashboard = true,
  --       packer = true,
  --       Trouble = true,
  --       lspinfo = true,
  --       terminal = true,
  --       checkhealth = true,
  --       man = true,
  --       mason = true,
  --       NvimTree = true,
  --       ["neo-tree"] = true,
  --       plugin = true,
  --       lazy = true,
  --       TelescopePrompt = true,
  --       markdown = false,
  --       ["markdown.pandoc"] = false,
  --     }
  --     return {
  --       chunk = {
  --         enable = true,
  --         use_treesitter = true,
  --         notify = false,
  --         exclude_filetypes = langs,
  --         style = "#cc241d",
  --         chars = {
  --           horizontal_line = "━",
  --           left_top = "┏",
  --           vertical_line = "┃",
  --           left_bottom = "┗",
  --           right_arrow = "━",
  --         },
  --       },
  --       indent = {
  --         enable = true,
  --         use_treesitter = false,
  --         chars = { "│", "¦", "┆", "┊" },
  --         exclude_filetypes = {
  --           lua = true,
  --           sh = true,
  --           python = true,
  --           c = true,
  --           cpp = true,
  --           diff = true,
  --           yaml = true,
  --           json = true,
  --         },
  --       },
  --       line_num = {
  --         enable = false,
  --         use_treesitter = false,
  --         style = "#fabd2f", -- Candidate colors.
  --       },
  --       blank = {
  --         enable = false,
  --         chars = { "·" },
  --         style = {
  --           vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID "Whitespace"), "fg", "gui"),
  --         },
  --       },
  --     }
  --   end,
  -- },

  -- TODO: TODO highlight
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    -- dependencies = { "echasnovski/mini.extra" },
    init = function()
      vim.cmd [[
			hi! MiniHipatternsTodo guifg=#ffffff guibg=#7daea3 gui=italic
			hi! MiniHipatternsFixme guifg=#ffffff guibg=#ea6962 gui=italic
			hi! MiniHipatternsHack guifg=#ffffff guibg=#d8a657 gui=italic
			hi! MiniHipatternsNote guifg=#ffffff guibg=#a9b665 gui=italic
			]]
    end,
    opts = function()
      local hi = require "mini.hipatterns"
      -- local hi_words = require("mini.extra").gen_highlighter.words
      return {
        highlighters = {
          --  fixme = hi_words({ "FIXME", "BUG", "ROBUSTNESS" }, "MiniHipatternsFixme"),
          --  todo = hi_words({ "TODO", "Todo", "REVIEW", "INCOMPLETE" }, "MiniHipatternsTodo"),
          --  hack = hi_words({ "HACK", "XXX" }, "MiniHipatternsHack"),
          --  note = hi_words({ "NOTE", "INFO" }, "MiniHipatternsNote"),
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
        },
      }
    end,
  },

  -- trailing whitespace
  {
    "echasnovski/mini.trailspace",
    event = "VeryLazy",
    config = true,
  },

  -- Bottom statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      -- lightweight replacement for fidget.nvim
      local progressText = ""
      local function lspProgress() return progressText end
      vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(ctx)
          local clientName = vim.lsp.get_client_by_id(ctx.data.client_id).name
          local progress = ctx.data.params.value ---@type {percentage: number, title?: string, kind: string, message?: string}
          if not (progress and progress.title) then return end

          local icons = { "󰫃", "󰫄", "󰫅", "󰫆", "󰫇", "󰫈" }
          local idx = math.floor(#icons / 2)
          if progress.percentage == 0 then idx = 1 end
          if progress.percentage and progress.percentage > 0 then
            idx = math.ceil(progress.percentage / 100 * #icons)
          end
          local firstWord = vim.split(progress.title, " ")[1]:lower()

          local text = table.concat({ icons[idx], clientName, firstWord }, " ")
          progressText = progress.kind == "end" and "" or text
        end,
      })
      --------------------------------------------------------------------------------
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
          ignore_focus = {
            "DressingInput",
            "DressingSelect",
            "lspinfo",
            "TelescopePrompt",
            "checkhealth",
            "noice",
            "lazy",
          },
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
          lualine_b = {
            {
              "branch",
              cond = function()
                -- only if not on main or master
                local curBranch = require("lualine.components.branch.git_branch").get_branch()
                return curBranch ~= "main" and curBranch ~= "master" and vim.bo.buftype == ""
              end,
            },
          },
          lualine_c = {
            { lspProgress },
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warning,
                info = icons.diagnostics.Information,
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
            { -- line count
              function() return vim.api.nvim_buf_line_count(0) .. " ☰" end,
              cond = function() return vim.bo.buftype == "" end,
            },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            { "selectioncount", fmt = function(str) return str ~= "" and "码" .. str or "" end },
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
    version = "*",
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
    commit = "1ea1c79",
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

  -- window border color
  -- {
  --   "nvim-zh/colorful-winsep.nvim",
  --   config = true,
  --   event = { "WinNew" },
  -- },

  -- prompt UI
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    event = "VeryLazy",
    opts = {
      routes = {
        -- FIX jedi bug https://github.com/pappasam/jedi-language-server/issues/296
        { filter = { event = "msg_show", find = "^}$" }, skip = true },
        -- FIX lsp signature bug
        { filter = { event = "msg_show", find = "lsp_signature? handler RPC" }, skip = true },
        -- redirect to popup when message is long
        { filter = { min_height = 10 }, view = "popup" },
        -- write/deletion messages
        { filter = { event = "msg_show", find = "%d+B written$" }, view = "mini" },
        { filter = { event = "msg_show", find = "%d+L, %d+B$" }, view = "mini" },
        { filter = { event = "msg_show", find = "%-%-No lines in buffer%-%-" }, view = "mini" },
        -- unneeded info on search patterns
        { filter = { event = "msg_show", find = "^[/?]." }, skip = true },
        { filter = { event = "msg_show", find = "^E486: Pattern not found" }, view = "mini" },
        -- Word added to spellfile via `zg`
        { filter = { event = "msg_show", find = "^Word .*%.add$" }, view = "mini" },
        -- Diagnostics
        {
          filter = { event = "msg_show", find = "No more valid diagnostics to move to" },
          view = "mini",
        },
        -- code actions
        { filter = { event = "notify", find = "No code actions available" }, view = "mini" },
        -- :make
        { filter = { event = "msg_show", find = "^:!make" }, skip = true },
        { filter = { event = "msg_show", find = "^%(%d+ of %d+%):" }, skip = true },
        -- nvim-early-retirement
        { filter = { event = "notify", find = "^Auto%-closing " }, view = "mini" },
        -- E211 no longer needed, since early-retirement closes deleted buffers
        { filter = { event = "msg_show", find = "E211: File .* no longer available" }, skip = true },
        -- nvim-treesitter
        { filter = { event = "msg_show", find = "^%[nvim%-treesitter%]" }, view = "mini" },
        { filter = { event = "notify", find = "All parsers are up%-to%-date" }, view = "mini" },
      },
      cmdline = {
        view = "cmdline", -- cmdline|cmdline_popup
        format = {
          search_down = { icon = "  ", view = "cmdline" }, -- FIX needs to be set explicitly
          cmdline = { view = "cmdline_popup" },
          lua = { view = "cmdline_popup" },
          help = { view = "cmdline_popup" },
        },
      },
      views = {
        cmdline_popup = {
          border = { style = "single" },
        },
        mini = {
          timeout = 3000,
          zindex = 10, -- lower, so it does not cover nvim-notify
          position = { col = -3 }, -- to the left to avoid collision with scrollbar
          format = { "{title} ", "{message}" }, -- leave out "{level}"
        },
        hover = {
          border = { style = "single" },
          size = { max_width = 80 },
          win_options = { scrolloff = 4, wrap = true },
        },
        popup = {
          border = { style = "single" },
          size = { width = 90, height = 25 },
          win_options = { scrolloff = 8, wrap = true },
          close = { keys = { "q" } },
        },
        split = {
          enter = true,
          size = "50%",
          close = { keys = { "q" } },
          win_options = { scrolloff = 6 },
        },
      },

      commands = {
        -- options for `:Noice history`
        history = {
          view = "split",
          filter_opts = { reverse = true }, -- show newest entries first
          -- https://github.com/folke/noice.nvim#-formatting
          opts = { format = { "{title} ", "{cmdline} ", "{message}" } },
        },
        last = {
          view = "popup",
          -- https://github.com/folke/noice.nvim#-formatting
          opts = { format = { "{title} ", "{cmdline} ", "{message}" } },
        },
      },
      lsp = {
        progress = { enabled = false },
        signature = { enabled = false }, -- replaced with lsp_signature.nvim
        hover = { enabled = true },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
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
      render = "wrapped-compact", -- best for shorter max_width
      max_width = 30,
      minimum_width = 15,
      top_down = false,
      fps = 5,
      level = 0, -- minimum severity level to display (0 = display all)
      timeout = 6000,
      stages = "static",
      icons = { ERROR = "", WARN = "", INFO = "", TRACE = "", DEBUG = "" },
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
  -- Better input/selection fields
  {
    "stevearc/dressing.nvim",
    init = function(spec)
      ---@diagnostic disable: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load { plugins = { spec.name } }
        return vim.ui.select(...)
      end

      vim.ui.input = function(...)
        require("lazy").load { plugins = { spec.name } }
        return vim.ui.input(...)
      end
      ---@diagnostic enable: duplicate-set-field
    end,
    keys = {
      { "<Tab>", "j", ft = "DressingSelect" },
      { "<S-Tab>", "k", ft = "DressingSelect" },
    },
    opts = {
      input = {
        trim_prompt = true,
        border = vim.g.borderStyle,
        relative = "editor",
        prefer_width = 45,
        min_width = 0.4,
        max_width = 0.8,
        mappings = { n = { ["q"] = "Close" } },
      },
      select = {
        trim_prompt = true,
        builtin = {
          mappings = { ["q"] = "Close" },
          show_numbers = false,
          border = vim.g.borderStyle,
          relative = "editor",
          max_width = 80,
          min_width = 20,
          max_height = 12,
          min_height = 3,
        },
        telescope = {
          layout_config = {
            horizontal = { width = { 0.7, max = 75 }, height = 0.6 },
          },
        },
        get_config = function(opts)
          local useBuiltin = { "plain", "codeaction", "rule_selection" }
          if vim.tbl_contains(useBuiltin, opts.kind) then
            return { backend = { "builtin" }, builtin = { relative = "cursor" } }
          end
        end,
      },
    },
  },
}
