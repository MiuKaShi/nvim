local M = {}

M.setup = function(on_attach, capabilities)
  vim.lsp.config("gopls", {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
  })
end

return M
