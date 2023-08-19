local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").matlab_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "matlab-language-server", "--stdio" },
    filetypes = { "matlab" },
    root_dir = function(fname) return require("lspconfig.util").find_git_ancestor(fname) or vim.fn.getcwd() end,
    single_file_support = true,
    settings = {
      matlab = {
        installPath = "/home/miuka/.local/MATLAB/R2023a",
      },
    },
  }
end

return M
