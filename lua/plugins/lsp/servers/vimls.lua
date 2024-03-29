local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").vimls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "vim" },
  }
end

return M
