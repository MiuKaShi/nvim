return {

  -- Snippet Engine
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    opts = function()
      local types = require "luasnip.util.types"
      require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/LuaSnip" }
      return {
        updateevents = "TextChanged,TextChangedI",
        history = true,
        delete_check_events = "TextChanged",
        enable_autosnippets = true,
        store_selection_keys = "`",
        ext_opts = {
          [types.insertNode] = { active = { virt_text = { { "●", "Boolean" } } } },
          [types.choiceNode] = { active = { virt_text = { { "↺", "markdownBold" } } } },
        },
      }
    end,
    keys = {
      { "<C-l>", function() require("luasnip").jump(1) end, mode = { "i", "s" } },
      { "<C-h>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "mstanciu552/cmp-matlab",
      "lukas-reineke/cmp-under-comparator",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "octaltree/cmp-look",
      -- {
      --   "zbirenbaum/copilot-cmp",
      --   dependencies = "zbirenbaum/copilot.lua",
      --   config = function() require("copilot_cmp").setup() end,
      -- },
      -- 'lukas-reineke/cmp-rg',
    },
    config = function()
      local cmp = require "cmp"
      -- limit the height of windows
      vim.opt.pumheight = 16
      local cmp_kinds = require("config").icons.cmp_kinds

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
      end

      local border_thin = {
        { "╭", "CmpBorder" },
        { "─", "CmpBorder" },
        { "╮", "CmpBorder" },
        { "│", "CmpBorder" },
        { "╯", "CmpBorder" },
        { "─", "CmpBorder" },
        { "╰", "CmpBorder" },
        { "│", "CmpBorder" },
      }

      local cmp_sources = {
        nvim_lsp = { name = "nvim_lsp", priority = 1000 },
        nvim_lsp_signature_help = { name = "nvim_lsp_signature_help", priority = 950 },
        buffer = { name = "buffer", priority = 900, keyword_length = 3, max_item_count = 5 },
				-- stylua: ignore start
        look = { name = "look", keyword_length = 2, priority = 850, option = { convert_case = true, loud = true, dict = vim.fn.stdpath "config" .. "/mydict/words.txt",} },
        luasnip = { name = "luasnip", priority = 800, option = { show_autosnippets = true } },
        -- copilot = { name = "copilot", priority = 700, max_item_count = 3 },
        supermaven = { name = "supermaven", priority = 700, max_item_count = 3 },
        matlab = { name = "cmp_matlab", priority = 650, max_item_count = 3 },
        path = { name = "path", priority = 600, max_item_count = 4 },
        cmdline = { name = "cmdline", priority = 630, max_item_count = 4 },
      }
      local defaultSources = {
        cmp_sources.buffer,
        cmp_sources.luasnip,
        cmp_sources.path,
      }

      cmp.setup {
        completion = { completeopt = "menu,menuone,noinsert" },
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-y>"] = cmp.config.disable,
          ["<CR>"] = cmp.config.disable,
          ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping {
            i = function(fallback)
              if cmp.visible() and has_words_before() then
                cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
              else
                fallback()
              end
            end,
          },
          ["<S-Tab>"] = cmp.config.disable,
        },
        performance = {
          -- all reduced, defaults: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua#L18-L25
          debounce = 30,
          throttle = 15,
          fetching_timeout = 300,
          confirm_resolve_timeout = 40,
          async_budget = 0.5,
          max_view_entries = 100,
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            -- limit the width of windows
            local get_ws = function(max, len) return string.rep(" ", (max - len)) end
            local ELLIPSIS_CHAR = "…"
            local MAX_LABEL_WIDTH = 25
            local content = item.abbr
            if #content > MAX_LABEL_WIDTH then
              item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
            else
              item.abbr = content .. get_ws(MAX_LABEL_WIDTH, #content)
            end
            -- Kind icons
            item.kind = cmp_kinds[item.kind]
            -- Source menu
            item.menu = ({
              buffer = "[Text]",
              nvim_lsp = "[LSP]",
              path = "[Path]",
              cmdline = "[Cmd]",
              luasnip = "[Snip]",
              cmp_matlab = "[MATLAB]",
              look = "[Dict]",
              supermaven = "[Sup]",
              -- copilot = "[Cop]",
              -- rg = '[RG]',
              -- neorg  = '[Norg]',
            })[entry.source.name]
            return item
          end,
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.recently_used,
            require("cmp-under-comparator").under,
            cmp.config.compare.score,
            cmp.config.compare.exact,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        duplicates = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          luasnip = 1,
        },
        window = {
          completion = {
            side_padding = 1,
            scrollbar = false,
            border = border_thin,
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
          },
          documentation = {
            border = border_thin,
          },
        },
        matching = { disallow_prefix_unmatching = true },
        sources = cmp.config.sources(defaultSources),
      }

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          cmp_sources.path,
          cmp_sources.cmdline,
        },
      })
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          cmp_sources.buffer,
        },
      })
      cmp.setup.filetype({ "markdown.pandoc", "markdown" }, {
        sources = cmp.config.sources {
          cmp_sources.nvim_lsp,
          cmp_sources.buffer,
          cmp_sources.look,
          cmp_sources.luasnip,
        },
      })
      cmp.setup.filetype({ "tex", "text" }, {
        sources = cmp.config.sources {
          cmp_sources.nvim_lsp,
          cmp_sources.nvim_lsp_signature_help,
          cmp_sources.buffer,
          cmp_sources.luasnip,
          cmp_sources.look,
        },
      })
      cmp.setup.filetype({ "matlab" }, {
        sources = cmp.config.sources {
          cmp_sources.matlab,
          cmp_sources.buffer,
          cmp_sources.path,
          cmp_sources.nvim_lsp,
          -- cmp_sources.copilot,
        },
      })
      cmp.setup.filetype({ "julia", "python", "lua", "glsl" }, {
        sources = cmp.config.sources {
          cmp_sources.nvim_lsp,
          cmp_sources.buffer,
          cmp_sources.luasnip,
          cmp_sources.path,
          cmp_sources.supermaven,
          -- cmp_sources.copilot,
        },
      })
    end,
    keys = {
      { "<leader>cs", function() require("util").cmp_toggle_source "luasnip" end },
      -- { "<leader>cg", function() require("util").cmp_toggle_source "copilot" end },
      { "<leader>cg", function() require("util").cmp_toggle_source "supermaven" end },
      { "<leader>cl", function() require("util").cmp_toggle_source "look" end },
      { "<leader>cb", function() require("util").cmp_toggle_source "buffer" end },
    },
  },
}
