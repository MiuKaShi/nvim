local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").foam_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "foam-ls", "--stdio" },
    filetypes = { "foam", "OpenFOAM" },
    single_file_support = true,
  }
end

return M
