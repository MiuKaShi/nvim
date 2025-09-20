local M = {}

M.setup = function(on_attach, capabilities)
  -- this block must come before lua LSP setup
  -- require("neodev").setup {}
  -- lua_ls setup
  vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" }, -- when contributing to nvim plugins missing a .luarc.json
          disable = { "trailing-space" }, -- formatter already does that
        },
        workspace = {
          library = {
            vim.fn.stdpath "data" .. "/lazy/emmylua-nvim",
          },
          checkThirdParty = false,
        },
        telemetry = { enable = false },
        hint = {
          enable = true, -- enabled inlay hints
          setType = true,
          arrayIndex = "Disable",
        },
        completion = {
          callSnippet = "Replace",
          keywordSnippet = "Replace",
          displayContext = 6,
          showWord = "Disable", -- don't suggest common words as fallback
          postfix = ".", -- useful for `table.insert` and the like
        },
      },
    },
  })
end

return M
