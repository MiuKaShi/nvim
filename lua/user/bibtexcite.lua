local M = {}

function M.config()
    -- bibcite 设置
    vim.g.bibtexcite_bibfile = '~/papers/bib/mybib_abb.bib'
    vim.g.bibtexcite_floating_window_border = { '│', '─', '╭', '╮', '╯', '╰' }
    vim.g.bibtexcite_close_preview_on_insert = 1

    -- bibcite 快捷键
    vim.cmd [[
autocmd FileType markdown inoremap <buffer> <silent> @@ <Esc>:BibtexciteInsert<CR>
]]
end

return M
