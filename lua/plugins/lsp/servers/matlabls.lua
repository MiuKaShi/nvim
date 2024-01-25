local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").matlab_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "matlab_ls", "--stdio" },
    filetypes = { "matlab" },
    root_dir = function(fname) return require("lspconfig.util").find_git_ancestor(fname) or vim.fn.getcwd() end,
    single_file_support = true,
    settings = {
      matlab = {
        indexWorkspace = false,
        installPath = "/home/miuka/.local/MATLAB/R2023b",
        matlabConnectionTiming = "onStart",
        telemetry = true,
      },
    },
  }
end

return M
