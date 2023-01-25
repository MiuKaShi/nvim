local status_ok, lspsaga = pcall(require, 'lspsaga')
if not status_ok then
    return
end

lspsaga.setup {
    error_sign = '🔥',
    warn_sign = '💩',
    hint_sign = '💡',
    infor_sign = '💬',
    diagnostic_header_icon = ' ',
    -- 正在写入的行提示
    code_action_icon = ' ',
    finder_action_keys = {
        open = '<CR>',
        vsplit = 's',
        split = 'o',
        quit = '<Esc>',
        scroll_down = '<C-f>',
        scroll_up = '<C-b>',
    },
    code_action_prompt = {
        -- 显示写入行提示
        -- 如果为 true ，则写代码时会在左侧行号栏中显示你所定义的图标
        enable = false,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
    },
    -- 快捷键配置
    code_action_keys = { quit = { 'q', '<ESC>' } },
    rename_action_keys = { quit = { 'q', '<ESC>' } },
}

-- lspconfig 服务地址 https://github.com/neovim/nvim-lspconfig
vim.keymap.set('n', 'J', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>") -- 预览定义
vim.keymap.set('n', 'K', "<cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>") -- 显示文档定义
vim.keymap.set('n', 'gr', "<cmd>lua require'lspsaga.rename'.rename()<CR>") -- 重命名变量
vim.keymap.set('n', 'gs', "<cmd>lua require'lspsaga.signaturehelp').signature_help()<CR>") -- 签名查看
vim.keymap.set('n', 'gS', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>") -- 诊断问题
vim.keymap.set('n', 'gh', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>") -- 异步查找单词定义、引用
vim.keymap.set('n', '<C-n>', "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<CR>") -- 滚动hover 下
vim.keymap.set('n', '<C-p>', "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<CR>") -- 滚动hover 上
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>') -- 关闭终端
