local M = {}

function M.setup()
    local status_ok, lualine = pcall(require, 'lualine')
    if status_ok then
        local colors = {
            darkgray = '#282828',
            gray = '#a89984',
            innerbg = nil,
            outerbg = '#282828',
            normal = '#458588',
            insert = '#689d6a',
            visual = '#d79921',
            replace = '#cc241d',
            command = '#ebdbb2',
        }

        local gruvboxline = {
            inactive = {
                a = { fg = colors.gray, bg = colors.outerbg, gui = 'bold' },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = colors.innerbg },
            },
            visual = {
                a = { fg = colors.darkgray, bg = colors.visual, gui = 'bold' },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = colors.innerbg },
            },
            replace = {
                a = { fg = colors.darkgray, bg = colors.replace, gui = 'bold' },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = colors.innerbg },
            },
            normal = {
                a = { fg = colors.darkgray, bg = colors.normal, gui = 'bold' },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = colors.innerbg },
            },
            insert = {
                a = { fg = colors.darkgray, bg = colors.insert, gui = 'bold' },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = colors.innerbg },
            },
            command = {
                a = { fg = colors.darkgray, bg = colors.command, gui = 'bold' },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = colors.innerbg },
            },
        }

        local hide_in_width = function()
            return vim.fn.winwidth(0) > 80
        end

        -- rime_status
        local function rime_status()
            if vim.g.rime_enabled then
                return 'CN'
            else
                return 'EN'
            end
        end

        local diff = {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
        }

        local diagnostics = {
            'diagnostics',
            symbols = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }, -- changes diff symbols
        }

        local getWords = {
            'getWords',
            fmt = function()
                if vim.bo.filetype == 'md' or vim.bo.filetype == 'text' or vim.bo.filetype == 'markdown.pandoc' then
                    if vim.fn.wordcount().visual_words == nil then
                        return tostring(vim.fn.wordcount().words)
                    end
                    return tostring(vim.fn.wordcount().visual_words)
                else
                    return ''
                end
            end,
            padding = 1,
            color = { fg = colors.orange2 },
        }

        lualine.setup {
            options = {
                theme = gruvboxline,
                icons_enabled = true,
                component_separators = '|',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { { 'mode', right_padding = 2 } },
                lualine_b = { 'branch' },
                lualine_c = {
                    'diagnostics',
                    { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                    { 'filename', path = 1, symbols = { modified = '  ', readonly = '', unnamed = '' } },
                },
                lualine_x = {
                    rime_status,
                    'diff',
                },

                lualine_y = {
                    getWords,
                    { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
                    { 'location', padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    function()
                        return ' ' .. os.date '%R'
                    end,
                },
            },
            extensions = {},
        }
    end
end

return M
