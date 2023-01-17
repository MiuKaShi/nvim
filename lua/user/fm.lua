local M = {}

function M.setup()
    local status_ok, fm = pcall(require, 'fm-nvim')
    if status_ok then
        fm.setup {
            edit_cmd = 'edit',
            ui = {
                default = 'float',
                float = { border = 'single', border_hl = 'NONE' },
            },
            cmds = {
                -- https://gist.github.com/Provessor/dbb4a6d22945e7a42c3b904302ee273c
                lf_cmd = '/usr/bin/lfrun',
            },
        }
    end
end

return M
