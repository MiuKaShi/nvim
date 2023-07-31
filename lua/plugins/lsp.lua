local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

return {
  -- lspconfig
  { "folke/neodev.nvim", opts = {}, ft = "lua" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
    },
    config = function()
      -- diagnostics signs
      local icons = require("config").icons.diagnostics
      for name, icon in pairs(icons) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      -- diagnostics config
      vim.diagnostic.config {
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      }

      -- lspconfig

      local function lsp_keymaps(client, bufnr)
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- stylua: ignore
				local keymaps = {
					{ "J",          '<cmd>Lspsaga peek_definition<CR>',       method = "definition" },
					{ "K",          '<cmd>Lspsaga hover_doc<CR>',             method = "document" },
					{ "gr",         '<cmd>Lspsaga rename<CR>',                method = "rename" },
					{ "gl",         '<cmd>Lspsaga show_line_diagnostics<CR>', method = "diagnostics" },
					{ "gh",         '<cmd>Lspsaga finder ref<CR>',            method = "references" },
					{ "<leader>ca", '<cmd>Lspsaga code_action<CR>',           mode = { "n", "v" },   method = "codeAction" },
					{ "[e",         '<cmd>Lspsaga diagnostic_jump_prev<CR>',  method = "jumpprev" },
					{ "]e",         '<cmd>Lspsaga diagnostic_jump_next<CR>',  method = "jumpnext" },
				}

        for _, keys in ipairs(keymaps) do
          if client.supports_method("textDocument/" .. keys.method) then
            vim.keymap.set(keys.mode or "n", keys[1], keys[2], { buffer = bufnr, desc = keys.method })
          end
        end
      end

      local function lsp_highlight(client, bufnr)
        if client.supports_method "textDocument/documentHighlight" then
          local group = augroup("lsp_document_highlight", {})
          autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end

      local function lsp_formatting(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.keymap.set(
            "n",
            "<leader>bf",
            function() vim.lsp.buf.format { async = true } end,
            { buffer = bufnr, desc = "Formmating" }
          )
        end
        if client.server_capabilities.documentRangeFormattingProvider then
          vim.keymap.set("v", "<leader>bf", vim.lsp.buf.format, { buffer = bufnr, desc = "Range Formmating" })
        end
      end

      local on_attach = function(client, bufnr)
        lsp_keymaps(client, bufnr)
        lsp_highlight(client, bufnr)
        lsp_formatting(client, bufnr)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then capabilities = cmp_nvim_lsp.default_capabilities(capabilities) end

      for _, server in ipairs {
        "pyright",
        "clangd",
        "cssls",
        "gopls",
        "jsonls",
        "htmls",
        "yamlls",
        "bashls",
        "vimls",
        "luals",
        "fortls",
        "julials",
        "texlab",
      } do
        require("plugins.lsp-servers." .. server).setup(on_attach, capabilities)
      end
      -- rime_ls server
      require "plugins.lsp-servers.rimels"
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
      {
        "<leader>xx",
        function() require("trouble").toggle() end,
        desc = "Trouble",
      },
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
      window = { border = "rounded" },
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
}
