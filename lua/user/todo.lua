local M = {}

function M.config()
    vim.keymap.set('n', ']t', function()
        require('todo-comments').jump_next()
    end, { desc = 'Next todo comment' })

    vim.keymap.set('n', '[t', function()
        require('todo-comments').jump_prev()
    end, { desc = 'Previous todo comment' })
end

function M.setup()
    local status_ok, todo = pcall(require, 'todo-comments')
    if status_ok then
        todo.setup {
            signs = true, -- show icons in the signs column
            sign_priority = 8, -- sign priority
            keywords = {
                FIX = {
                    icon = ' ', -- icon used for the sign, and in search results
                    color = 'error', -- can be a hex color, or a named color (see below)
                    alt = { 'FIXME', 'fixme', 'BUG', 'bug', 'FIXIT', 'fixit', 'ISSUE', 'issue' },
                },
                TODO = { icon = ' ', color = 'info', alt = { 'todo', 'todos', 'TODOS' } },
                HACK = { icon = ' ', color = 'warning' },
                WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'warning', 'XXX', 'warn' } },
                PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
                NOTE = { icon = ' ', color = 'hint', alt = { 'INFO', 'note', 'info' } },
                TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
            },
            gui_style = {
                fg = 'NONE', -- The gui style to use for the fg highlight group.
                bg = 'BOLD', -- The gui style to use for the bg highlight group.
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            highlight = {
                before = '', -- "fg" or "bg" or empty
                keyword = 'wide',
                after = 'fg', -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            colors = {
                error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
                warning = { 'DiagnosticWarning', 'WarningMsg', '#FBBF24' },
                info = { 'DiagnosticInfo', '#2563EB' },
                hint = { 'DiagnosticHint', '#10B981' },
                default = { 'Identifier', '#7C3AED' },
                test = { 'Identifier', '#FF00FF' },
            },
            search = {
                command = 'rg',
                args = {
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                },
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
            },
        }
    end
end

return M
