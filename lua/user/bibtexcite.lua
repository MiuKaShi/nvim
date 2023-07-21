local M = {}

function M.config()
    -- bibcite 设置
    vim.g.bibtexcite_bibfile = '~/papers/bib/mybib.bib'
    vim.g.bibtexcite_floating_window_border = { '│', '─', '╭', '╮', '╯', '╰' }
    vim.g.bibtexcite_close_preview_on_insert = 1

    vim.keymap.set('n', '<leader>bo', ':BibtexciteOpenfile<CR>') -- Bib Open pdf
    vim.keymap.set('n', '<leader>bv', ':BibtexciteShowcite<CR>') -- Bib citation view
    vim.keymap.set('n', '<leader>be', ':BibtexciteEdit<CR>') -- Bib citation view
    vim.keymap.set('n', '<leader>bn', ':BibtexciteNote<CR>') -- Bib citation view

    vim.cmd [[autocmd FileType markdown.pandoc inoremap <buffer> <silent> @@ <Esc>:BibtexciteInsert<CR>]]
end

return M
