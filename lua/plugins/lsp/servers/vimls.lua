local M = {}

M.setup = function(on_attach, capabilities)
  vim.lsp.config("vimls", {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "vim" },
  })
end

return M
