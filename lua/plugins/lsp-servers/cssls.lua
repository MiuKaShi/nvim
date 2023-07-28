local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "vscode-css-language-server", "--stdio" },
    flags = { debounce_text_changes = 150 },
  }
end

return M
