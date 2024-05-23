local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").matlab_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "matlab_ls", "--stdio" },
    filetypes = { "matlab" },
    root_dir = require("lspconfig.util").root_pattern "*.m",
    -- root_dir = function(fname) return require("lspconfig.util").find_git_ancestor(fname) or vim.fn.getcwd() end,
    settings = {
      matlab = {
        indexWorkspace = true,
        installPath = "/home/miuka/.local/MATLAB/R2024a",
        matlabConnectionTiming = "onStart",
        telemetry = true,
      },
    },
    single_file_support = true,
  }
end

return M
