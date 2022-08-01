local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').fortls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
            'fortls',
            '--hover_signature',
            '--hover_language=fortran',
            '--use_signature_help',
        },
        filetypes = { "fortran", "Fortran77" },
        root_dir = function(fname)
            local util = require "lspconfig/util"
            return util.root_pattern(".fortls", ".git")(fname) or vim.fn.getcwd()
        end,
        settings = { nthreads = 2, }
    }
end

return M
