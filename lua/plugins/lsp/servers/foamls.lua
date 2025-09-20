local M = {}

M.setup = function(on_attach, capabilities)
  vim.lsp.config("foam_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "foam-ls", "--stdio" },
    filetypes = { "foam", "OpenFOAM" },
    single_file_support = true,
  })
end

return M
