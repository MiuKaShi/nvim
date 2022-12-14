local status_ok, copilot = pcall(require, 'copilot')
if not status_ok then
    return
end

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
