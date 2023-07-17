local M = {}

function M.config()
    vim.keymap.set('n', 'J', '<cmd>Lspsaga peek_definition<CR>') -- 预览定义
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>') -- 显示文档定义
    vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>') -- 重命名变量
    vim.keymap.set('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<CR>') -- 诊断问题
    vim.keymap.set('n', 'gh', '<cmd>Lspsaga finder ref<CR>') -- 查找变量名
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>')
    vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>') -- 滚动hover 上
    vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>') -- 滚动hover 下
end

function M.setup()
    require('lspsaga').setup {
        symbol_in_winbar = {
            enable = false,
        },
        lightbulb = {
            enable = false,
        },
        ui = {
            theme = 'round',
            winblend = 0,
            title = false,
            border = 'single',
            expand = '',
            collapse = '',
            colors = {
                normal_bg = 'none',
                title_bg = 'none',
                red = '#ea6962',
                magenta = '#98869a',
                orange = '#e78a4e',
                yellow = '#d8a657',
                green = '#a9b665',
                cyan = '#89b482',
                blue = '#7daea3',
                purple = '#d3869b',
                white = '#d1d4cf',
                black = '#1e2030',
            },
        },
        scroll_preview = {
            scroll_down = '<C-9>',
            scroll_up = '<C-0>',
        },
    }
end

return M
