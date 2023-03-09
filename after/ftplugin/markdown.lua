vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.wo.conceallevel = 2
vim.bo.expandtab = true
vim.bo.spelllang = 'en_us,cjk'

-- pandoc sytanx setting
vim.g['pandoc#syntax#conceal#blacklist'] = {
    'atx',
    'ellipses',
    'emdashes',
    'codeblock_start',
    'codeblock_delim',
}
vim.g.tex_conceal = 'amgs' --disable equation conceal
vim.g['pandoc#syntax#codeblocks#embeds#langs'] =
    { 'python', 'bash=sh', 'c', 'cpp', 'latex=tex', 'diff', 'julia', 'rust' }

vim.keymap.set('n', '<leader>pp', '<cmd>MarkdownPreviewToggle<CR>') -- 预览
