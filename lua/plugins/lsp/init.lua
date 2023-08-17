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
          focusable = false,
          style = "minimal",
          border = "single",
          source = "always",
          header = "",
          prefix = "",
        },
      }

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
      } do
        require("plugins.lsp.servers." .. server).setup(on_attach, capabilities)
      end
      -- rime_ls server
      require "plugins.lsp.servers.rimels"
    end,
  },

  -- lsp enhancement
  {
    "nvimdev/lspsaga.nvim",
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
      ui = {
        theme = "round",
        winblend = 0,
        title = false,
        border = "single",
        expand = "",
        collapse = "",
        colors = {
          normal_bg = "none",
          title_bg = "none",
          red = "#ea6962",
          magenta = "#98869a",
          orange = "#e78a4e",
          yellow = "#d8a657",
          green = "#a9b665",
          cyan = "#89b482",
          blue = "#7daea3",
          purple = "#d3869b",
          white = "#d1d4cf",
          black = "#1e2030",
        },
        scroll_preview = {
          scroll_down = "<C-9>",
          scroll_up = "<C-0>",
        },
      },
    },
    cmd = "Lspsaga",
		-- stylua: ignore
		keys = {
			{ "gh", function() require("lspsaga.finder"):new({}) end, silent = true, desc = "Lsp Finder" }
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

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function() require "plugins.lsp.null-ls" end,
  },
}
