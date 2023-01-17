local M = {}

function M.config()
    local status_ok, obsidian = pcall(require, 'obsidian')
    if status_ok then
        obsidian.setup {
            dir = '~/notes',
            completion = {
                nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
            },
            notes_subdir = 'day_notes',
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format.
                local suffix = ''
                if title ~= nil then
                    -- If title is given, transform it into lowercase.
                    suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
                    suffix = tostring(os.date '%Y%m%d%H%M%S') .. '-' .. suffix
                else
                    -- If title is nil, Zettelkasten format file name.
                    suffix = tostring(os.date '%Y%m%d%H%M%S')
                end
                return suffix
            end,
        }
    end
end

return M
