local M = {}

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = '99999'

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

function M.config()
    local status_ok, indent_blankline = pcall(require, 'indent_blankline')
    if status_ok then
        require('indent_blankline').setup {
            buftype_exclude = {
                'nofile',
                'terminal',
                'lsp-installer',
                'lspinfo',
            },
            filetype_exclude = {
                'help',
                'startify',
                'aerial',
                'alpha',
                'dashboard',
                'packer',
                'neogitstatus',
                'NvimTree',
                'neo-tree',
                'Trouble',
            },
            context_patterns = {
                'class',
                'return',
                'function',
                'method',
                '^if',
                '^while',
                'jsx_element',
                '^for',
                '^object',
                '^table',
                'block',
                'arguments',
                'if_statement',
                'else_clause',
                'jsx_element',
                'jsx_self_closing_element',
                'try_statement',
                'catch_clause',
                'import_statement',
                'operation_type',
            },
            char = '▏',
            use_treesitter = true,
            show_trailing_blankline_indent = false,
            show_current_context = true,
            char_highlight_list = {
                'IndentBlanklineIndent1',
                'IndentBlanklineIndent2',
                'IndentBlanklineIndent3',
                'IndentBlanklineIndent4',
                'IndentBlanklineIndent5',
                'IndentBlanklineIndent6',
            },
        }
    end
end

return M
