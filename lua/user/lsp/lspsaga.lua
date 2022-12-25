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

local function _map(mode, shortcut, command)
    vim.api.nvim_set_keymap(
        mode,
        shortcut,
        command,
        { noremap = true, silent = true }
    )
end

local function map(shortcut, command)
    _map('', shortcut, command)
end

local function nmap(shortcut, command)
    _map('n', shortcut, command)
end

local function imap(shortcut, command)
    _map('i', shortcut, command)
end

local function vmap(shortcut, command)
    _map('v', shortcut, command)
end

local function cmap(shortcut, command)
    _map('c', shortcut, command)
end

local function tmap(shortcut, command)
    _map('t', shortcut, command)
end

-- lspconfig 服务地址 https://github.com/neovim/nvim-lspconfig

nmap('J', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>") -- 预览定义
nmap('K', "<cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>") -- 显示文档定义
nmap('gr', "<cmd>lua require'lspsaga.rename'.rename()<CR>") -- 重命名变量
nmap('gs', "<cmd>lua require'lspsaga.signaturehelp').signature_help()<CR>") -- 签名查看
nmap('gS', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>") -- 诊断问题
nmap('gh', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>") -- 异步查找单词定义、引用
nmap('<C-n>', "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<CR>") -- 滚动hover 下
nmap('<C-p>', "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<CR>") -- 滚动hover 上
tmap('<ESC>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>') -- 关闭终端
