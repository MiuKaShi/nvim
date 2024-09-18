return {
  -- lspconfig
  { "ii14/emmylua-nvim", ft = "lua" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "none-ls.nvim",
    },
    config = function()
      -- diagnostics signs
      --vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      --border = "single",
      --})

      --vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      --border = "single",
      --})

      -- diagnostics config
      local icons = require("config").icons
      vim.diagnostic.config {
        update_in_insert = false,
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
          },
        },
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          prefix = "●",
        },
        float = {
          focusable = true,
          border = "single",
          max_width = 75,
          header = "", -- remove "Diagnostics:" heading
        },
      }
      require("lspconfig.ui.windows").default_options.border = "single"

      -- attach
      local on_attach = function(client, bufnr) require("plugins.lsp.attach").on_attach(client, bufnr) end

      -- capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Enable snippets-completion (for nvim_cmp)
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- Enable folding (for nvim-ufo)
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      for _, server in ipairs {
        "pyright",
        "clangd",
        "cssls",
        "gopls",
        "jsonls",
        "htmls",
        "bashls",
        "vimls",
        "luals",
        "fortls",
        "julials",
        "texlab",
        "yamlls",
        "foamls",
        "matlabls",
      } do
        require("plugins.lsp.servers." .. server).setup(on_attach, capabilities)
      end
      -- rime_ls server
      -- require "plugins.lsp.servers.rimels"
      require("plugins.lsp.servers.rimels").setup_rime()
    end,
  },

  -- lsp enhancement
  -- {
  --   "nvimdev/lspsaga.nvim",
  --   opts = {
  --     symbol_in_winbar = {
  --       enable = false,
  --     },
  --     lightbulb = {
  --       enable = false,
  --     },
  --     ui = {
  --       theme = "round",
  --       winblend = 0,
  --       title = false,
  --       border = "single",
  --       expand = "",
  --       collapse = "",
  --       colors = {
  --         normal_bg = "none",
  --         title_bg = "none",
  --         red = "#ea6962",
  --         magenta = "#98869a",
  --         orange = "#e78a4e",
  --         yellow = "#d8a657",
  --         green = "#a9b665",
  --         cyan = "#89b482",
  --         blue = "#7daea3",
  --         purple = "#d3869b",
  --         white = "#d1d4cf",
  --         black = "#1e2030",
  --       },
  --       scroll_preview = {
  --         scroll_down = "<C-9>",
  --         scroll_up = "<C-0>",
  --       },
  --     },
  --   },
  --   cmd = "Lspsaga",
  -- -- stylua: ignore
  -- keys = {
  --    { "gh", function() require("lspsaga.finder"):new({}) end, silent = true, desc = "Lsp Finder" }
  -- },
  -- },

  {
    "dnlhc/glance.nvim",
    opts = {
      border = { enable = true },
      hooks = {
        ---Don't open glance when there is only one result and it is located in the current buffer, open otherwise
        before_open = function(results, open, jump)
          local uri = vim.uri_from_bufnr(0)
          if #results == 1 then
            local target_uri = results[1].uri or results[1].targetUri

            if target_uri == uri then
              jump(results[1])
            else
              open(results)
            end
          else
            open(results)
          end
        end,
      },
    },
  },

  -- code check
  {
    "folke/trouble.nvim",
    opts = {
      mode = "document_diagnostics",
      auto_close = true,
      position = "bottom",
      signs = {
        error = "🔥",
        warning = "💩",
        hint = "💡",
        information = "💬",
        other = "📌",
      },
      use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
      action_keys = {
        close = "<esc>",
        previous = "k",
        next = "j",
      },
    },
    cmd = "TroubleToggle",
    keys = {
      { "<leader>tt", "<cmd>TroubleToggle<cr>", desc = "trouble toggle" },
      { "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", desc = "trouble toggle quickfix" },
    },
  },

  -- funcion check
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = { border = "single" },
      lsp = { auto_attach = true },
    },
    keys = {
      -- stylua: ignore
      { "<leader>n", function() require("nvim-navbuddy").open() end, desc = "Navigator" },
    },
  },

  -- signature hints
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    dependencies = "folke/noice.nvim",
    opts = {
      noice = true, -- render via noice.nvim
      hint_prefix = "󰏪 ",
      hint_scheme = "@variable.parameter", -- highlight group
      hint_inline = function() return vim.lsp.inlay_hint ~= nil end,
      floating_window = false,
      always_trigger = true,
    },
  },

  -- better LSP variable-rename
  {
    "smjonas/inc-rename.nvim",
    event = "CmdlineEnter", -- loading with `cmd = "IncRename` does not work with incremental preview
    opts = {
      -- if more than one file is changed, save all buffers
      post_hook = function(results)
        if not results.changes then return end
        local filesChanged = #vim.tbl_keys(results.changes)
        if filesChanged > 1 then vim.cmd.wall() end
      end,
    },
  },

  -- none-ls
  {
    "nvimtools/none-ls.nvim",
    -- commit = "bb680d7",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function() require "plugins.lsp.none-ls" end,
  },

  -- counts of functions
  {
    "Wansmer/symbol-usage.nvim",
    event = (vim.fn.has "nvim-0.10.0" == 1 and "LspAttach" or "BufReadPre"), -- TODO
    opts = {
      hl = { link = "NonText" },
      vt_position = "end_of_line",
      request_pending_text = false, -- no "Loading…" PENDING https://github.com/Wansmer/symbol-usage.nvim/issues/24
      references = { enabled = true, include_declaration = false },
      definition = { enabled = false },
      implementation = { enabled = false },
      -- available symbolkinds: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
      kinds = {
        vim.lsp.protocol.SymbolKind.Function,
        vim.lsp.protocol.SymbolKind.Method,
        vim.lsp.protocol.SymbolKind.Object,
      },
      text_format = function(symbol)
        if symbol.references == 0 then return "" end
        return "🌿 " .. symbol.references
      end,
    },
  },
  -- add ignore-comments & lookup rules
  -- {
  --   "chrisgrieser/nvim-rulebook",
  --   keys = {
  --     {
  --       "<leader>rl",
  --       function() require("rulebook").lookupRule() end,
  --       desc = " Lookup Rule",
  --     },
  --     {
  --       "<leader>rg",
  --       function() require("rulebook").ignoreRule() end,
  --       desc = "󰅜 Ignore Rule",
  --     },
  --   },
  -- },
}
