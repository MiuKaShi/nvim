local M = {}

-- require('neodev').setup {
--     lspconfig = {

M.setup = function(on_attach, capabilities)
    -- this block must come before lua LSP setup
    require("neodev").setup {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT', -- Lua 5.1/LuaJIT
          },
          completion = { callSnippet = "Disable" },
          workspace = { maxPreload = 10000 },
        },
      },
    }
    require('lspconfig').sumneko_lua.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = { globals = { 'vim', 'use' } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
                hint = {
                    enable = true,
                    settype = true,
                },
            },
        },
    }
end

return M
