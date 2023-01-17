local M = {}

function M.setup()
    local status_ok, copilot = pcall(require, 'copilot')
    if status_ok then
        copilot.setup {
            filetypes = {
                c = false,
                cpp = false,
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ['.'] = false,
            },
            copilot_node_command = 'node', -- Node.js version must be > 16.x
            server_opts_overrides = {},
        }
    end
end

return M
