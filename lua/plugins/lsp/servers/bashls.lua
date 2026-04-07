local M = {}

M.setup = function(on_attach, capabilities)
  vim.lsp.config("bashls", {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash", "zsh" },
  })
end

return M
