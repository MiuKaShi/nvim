local M = {}

M.setup = function(on_attach, capabilities)
  vim.lsp.config("pyright", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
        },
      },
    },
  })
end

return M
