vim.wo.conceallevel = 2
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.wo.spell = true
vim.bo.spelllang = 'en_us,cjk'

-- pandoc sytanx setting
vim.g['pandoc#syntax#conceal#blacklist'] = {
    'atx',
    'ellipses',
    'emdashes',
    'codeblock_start',
    'codeblock_delim',
}
vim.g.tex_conceal='amgs' --disable equation conceal 
vim.g['pandoc#syntax#codeblocks#embeds#langs'] =
    { 'html', 'python', 'bash=sh', 'c', 'cpp', 'latex=tex', 'diff' }
