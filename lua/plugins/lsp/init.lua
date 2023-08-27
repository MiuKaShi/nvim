return {
  -- lspconfig
  { "ii14/emmylua-nvim", ft = "lua" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "null-ls.nvim",
    },
    config = function()
      -- diagnostics signs
      local diagnostic_icons = require("config").icons.diagnostics
      for name, icon in pairs(diagnostic_icons) do
        local sign_name = "DiagnosticSign" .. name
        vim.fn.sign_define(sign_name, { texthl = sign_name, text = icon, numhl = "" })
      end

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
      })

      -- diagnostic keymaps
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Float Diagnostics" })
      vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = "󰒕 Previous Diagnostics" })
      vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = "󰒕 Next Diagnostics" })

      -- diagnostics config
      vim.diagnostic.config {
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          prefix = "●",
        },
        float = {
          focusable = true,
          border = "single",
          source = "if_many",
        },
      }
      require("lspconfig.ui.windows").default_options.border = "single"

      -- attach
      local on_attach = function(client, bufnr) require("plugins.lsp.attach").on_attach(client, bufnr) end

      -- capabilities
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

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
        "matlabls",
      } do
        require("plugins.lsp.servers." .. server).setup(on_attach, capabilities)
      end
      -- rime_ls server
      require "plugins.lsp.servers.rimels"
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
  -- 	{ "gh", function() require("lspsaga.finder"):new({}) end, silent = true, desc = "Lsp Finder" }
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
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "trouble toggle" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "trouble toggle quickfix" },
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
      {
        "<leader>n",
        function() require("nvim-navbuddy").open() end,
        desc = "Navigator",
      },
    },
  },

  { -- better LSP variable-rename
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

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function() require "plugins.lsp.null-ls" end,
  },
}
