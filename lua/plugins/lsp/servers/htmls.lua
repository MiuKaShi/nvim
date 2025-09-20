local M = {}

M.setup = function(on_attach, capabilities)
  vim.lsp.config("html", {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "blade" },
  })
end

return M
