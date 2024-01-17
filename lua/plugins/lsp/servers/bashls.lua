local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
  }
end

return M
