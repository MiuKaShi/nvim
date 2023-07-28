local M = {}

M.setup = function(on_attach, capabilities)
  -- this block must come before lua LSP setup
  require("neodev").setup {}
  -- lua_ls setup
  require("lspconfig").lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = { globals = { "vim", "use" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
        hint = {
          enable = true,
          settype = true,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  }
end

return M
