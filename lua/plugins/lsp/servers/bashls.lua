local M = {}

M.setup = function(on_attach, capabilities)
  vim.lsp.config("bashls", {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
  })
end

return M
