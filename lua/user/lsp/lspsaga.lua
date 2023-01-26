local status_ok, lspsaga = pcall(require, 'lspsaga')
if not status_ok then
    return
end

lspsaga.setup {
    symbol_in_winbar = {
        enable = false,
    },
    lightbulb = {
        enable = true,
        enable_in_insert = true,
        sign = false,
        sign_priority = 40,
        virtual_text = true,
    },
    ui = {
        theme = 'round',
        title = false,
        winblend = 0,
        border = 'single',
        expand = '',
        collapse = '',
        preview = '💬',
        code_action = '💡',
        diagnostic = '🔥',
        incoming = ' ',
        outgoing = ' ',
        colors = {
            normal_bg = 'none',
            title_bg = 'none',
            red = '#ff757f',
            magenta = '#c099ff',
            orange = '#ff966c',
            yellow = '#ffc777',
            green = '#c3e88d',
            cyan = '#86e1fc',
            blue = '#82aaff',
            purple = '#fca7ea',
            white = '#d1d4cf',
            black = '#1e2030',
        },
    },
}
local keymap = vim.keymap.set
keymap('n', 'J', '<cmd>Lspsaga peek_definition<CR>') -- 预览定义
keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>') -- 显示文档定义
keymap('n', 'gr', '<cmd>Lspsaga rename<CR>') -- 重命名变量
keymap('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<CR>') -- 诊断问题
keymap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>') -- 查找变量名
keymap({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>')
keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>') -- 滚动hover 上
keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>') -- 滚动hover 下
