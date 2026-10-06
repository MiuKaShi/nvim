return {
  cmd = { "matlab_ls", "--stdio" },
  filetypes = { "matlab" },
  -- root_dir = require("lspconfig.util").root_pattern(".git", "*.prj"),
  settings = {
    matlab = {
      indexWorkspace = true,
      installPath = "/home/miuka/.local/MATLAB/R2025b", -- bug with this, default is fine
      matlabConnectionTiming = "onStart",
      telemetry = true,
    },
  },
  single_file_support = true,
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end, -- disable diagnostics, null_ls handles this
  },
}
