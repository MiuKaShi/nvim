local M = {}

function M.setup()
    local status_ok, sentiment = pcall(require, 'sentiment')
    if status_ok then
        sentiment.setup {
            included_buftypes = {
                [''] = true,
            },
            excluded_filetypes = {},
            included_modes = {
                n = false,
                i = true,
            },
            delay = 50,
            limit = 100,
            pairs = {
                { '(', ')' },
                { '{', '}' },
                { '[', ']' },
            },
        }
    end
    vim.cmd [[highlight MatchParen guifg=#CFD2D5 guibg=#606366]]
end

return M
