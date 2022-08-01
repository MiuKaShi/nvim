vim.cmd [[
function! g:Open_browser(url)
    silent exec "!surf " . a:url . " &"
endfunction
]]

vim.g.mkdp_browserfunc = 'g:Open_browser'
vim.g.mkdp_markdown_css = '/home/miuka/.config/nvim/darkdown.css'
vim.g.mkdp_page_title = '${name}.md'
vim.g.mkdp_filetypes = { 'markdown' }
vim.g.mkdp_preview_options = {
    mkit = {},
    katex = {},
    uml = {},
    maid = {},
    disable_sync_scroll = 0,
    sync_scroll_type = 'middle',
    hide_yaml_meta = 1
}
-- set default theme (dark or light)
vim.g.mkdp_theme = 'dark'
