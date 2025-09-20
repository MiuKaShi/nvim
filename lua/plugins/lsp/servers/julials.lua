-- Installation:
-- https://github.com/josephsdavid/juliacli
local M = {}

M.setup = function(on_attach, capabilities)
  vim.lsp.config("julials", {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "juliacli", "server" },
    settings = {
      julia = {
        usePlotPane = false,
        symbolCacheDownload = false,
        runtimeCompletions = true,
        singleFileSupport = true,
        useRevise = true,
        lint = {
          NumThreads = 6,
          missingrefs = "all",
          iter = true,
          lazy = true,
          modname = true,
        },
      },
    },
  })
end

return M
