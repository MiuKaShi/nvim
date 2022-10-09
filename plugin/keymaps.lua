vim.g.mapleader = ' '

local function _map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
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

-- Setup for keybindings
-- insert mode
imap('<C-a>', '<Esc>0i')
imap('<C-e>', '<End>')
imap('<C-n>', '<Plug>(fzf-complete-wordnet)')

-- normal mode
nmap('<C-l>', '<cmd>bnext<CR>') -- buffer 跳转
nmap('<C-h>', '<cmd>bprev<CR>')
nmap('<C-s>', '<cmd>write<CR>')
nmap('<C-w>', '<cmd>bdelete<CR>') -- file tree
nmap('j', 'gj')
nmap('k', 'gk')
nmap('<leader>;;', 'gcc')

vmap('<leader>;', 'gcc<esc>')

-- command line mode
cmap('<C-a>', '<Home>')
cmap('<C-e>', '<End>')
cmap('<C-h>', '<BS>')
cmap('<C-k>', '<C-f>D<C-c><C-c>:<Up>')
-- End of setup for emacs keybindings

-- lspconfig 服务地址 https://github.com/neovim/nvim-lspconfig
nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>') -- 跳转定义
nmap('J', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>") -- 预览定义
nmap('K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>") -- 显示文档定义
nmap('<C-n>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>") -- 滚动hover 下
nmap('<C-p>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>") -- 滚动hover 上
nmap('<C-f>', '<cmd>Telescope find_files<CR>') -- 查找文件
nmap('gs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>") -- 签名查看
nmap('gS', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>") -- 诊断问题
nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>') -- 跳转实现
nmap('gn', ':BufferLineCycleNext<CR>') -- 下一个文件
nmap('gp', ':BufferLineCyclePrev<CR>') -- 上一个文件
nmap('gr', "<cmd>lua require('lspsaga.rename').rename()<CR>") -- 重命名变量
nmap('ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>") -- 代码操作
vmap('ca', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>") -- 选中的代码操作
nmap('gh', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>") -- 异步查找单词定义、引用
tmap('<ESC>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>') -- 关闭终端

-- telescope alias
local themes = require 'telescope.themes'
local tb = require 'telescope.builtin'
local te = require('telescope').extensions

local wk = require 'which-key'
wk.register({
    ['w']       = {
        name  = '+Windows',
        s     = { '<C-w>s', 'Split window below' },
        v     = { '<C-w>v', 'Split window right' },
        ['-'] = { '<C-w>s', 'Split window below' },
        ['/'] = { '<C-w>v', 'Split window right' },
        w     = { '<C-w>w', 'Other window' },
        j     = { '<C-w>j', 'Go to the down window' },
        k     = { '<C-w>k', 'Go to the up window' },
        h     = { '<C-w>h', 'Go to the left window' },
        l     = { '<C-w>l', 'Go to the right window' },
        q     = { '<C-w>c', 'Close window' },
        m     = { '<C-w>o', 'Maximize window' },
    },
    ['b']       = {
        name = '+Buffers',
        b = { "<cmd>lua require('telescope.builtin').buffers { sort_mru = true }<CR>", 'List buffers' },
        n = { ':BufferLineCycleNext<CR>', 'Next buffer' },
        p = { ':BufferLineCyclePrev<CR>', 'Previous buffer' },
        d = { ':bw<CR>', 'Delete buffer' },
        f = { '<cmd>lua vim.lsp.buf.format(nil, 200)<cr>', 'Format' },
        c = { '<cmd>BibtexciteInsert<CR>', 'Bib citation insert' },
        v = { '<cmd>BibtexciteShowcite<CR>', 'Bib citation view' },
        o = { '<cmd>BibtexciteOpenfile<CR>', 'Bib Open pdf' },
    },
    ['f']       = {
        name = '+Find',
        -- use keys from telescope configs,
    },
    ['p']       = {
        name = '+Projects',
        f = { '<cmd>Telescope find_files<CR>', 'Find file by name(<CTRL-P>)' },
    },
    ['j']       = {
        name = '+Jump',
        j = { '<Plug>(easymotion-s)', 'Jump to char' },
        l = { '<Plug>(easymotion-bd-jk)', 'Jump to line' },
        i = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", 'Jump to symbol' },
    },
    ['s']       = {
        name = '+Save/Symbols',
        s = { '<cmd>w ! sudo tee > /dev/null %<CR>', 'Force save file' },
        e = { ':Lspsaga rename<CR>', 'Edit symbol' },
        h = { "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", 'Hover symbol' },
        p = { "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", 'Preview symbol' },
        H = { "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", 'Show symbol signature' },
    },
    ['g']       = {
        name = '+Git',
        s = { ':Magit<CR>', 'Magit status, see: vimagit' }, -- git状态显示
        g = { ':Flog<CR>', 'Show git commit graph' }, -- git图像显示
        c = { "<cmd> lua require('telescope.builtin').git_commits()<CR>", 'Show commits(grep)' }, -- git commits 可过滤
        b = { "<cmd> lua require('telescope.builtin').git_branches()<CR>", 'Show branches(grep)' }, -- git branchs 可过滤
    },
    ['e']       = {
        name = '+Errors',
        a = { "<cmd>lua require('telescope.builtin').diagnostics{ bufnr=0 }<CR>", 'List all errors' },
        k = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'lspsaga.diagnostic PREV' },
        j = { '<cmd>lua vim.diagnostic.goto_next()<CR>', 'lspsaga.diagnostic NEXT' },
        f = { ':Lspsaga code_action<CR>', 'Fix error' },
    },
    ['c']       = {
        name = '+Compiler',
        c = { ':!compiler <c-r>%<CR><CR>', 'Compiler files' },
        p = { ':silent !st autoprev <c-r>%<CR><CR>', 'Preivew files' },
    },
    [';']       = {
        name = 'comment',
        [';'] = { 'gcc<esc>', 'comment line', noremap = false, mode = 'v' },
        f = { '<cmd>lua vim.lsp.buf.range_formatting()<cr>', "format", noremap = false, mode = "v" },
    },
    t           = { ':Lspsaga open_floaterm<CR>', 'Open Terminal(exit with <ESC>)' }, -- 打开终端
    l           = { ':call ToggleHiddenAll()<CR>', 'LSP Toggle' }, -- LSP 开关
    i           = { ':setlocal spell! spelllang=en_us<CR>', 'Spell Check' }, -- Spell check
    ['*']       = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", 'Search reference in current project' }, -- lsp 查找引用
    ['/']       = { ':Telescope live_grep previewer=false <CR>', 'Fuzzy search in project' }, -- 项目内查找
    ['!']       = { ':Telescope help_tags theme=ivy<CR>', 'Help commands by fuzzy search' }, -- vim帮助查找
    ['<Tab>']   = { ':b#<CR>', 'Last buffer' },
    ['<Space>'] = { ':Lf<CR>', 'Toggle directory tree' }, -- 查找命令
}, { prefix = '<leader>' })

-- bibcite 快捷键
vim.cmd [[
autocmd FileType markdown inoremap <buffer> <silent> @@ <Esc>:BibtexciteInsert<CR>
]]
-- 保存前格式化

-- vim.cmd [[
--   autocmd BufWritePre *.rs,*.js,*.ts,*.jsx,*.tsx,*.json,*.yaml,*.toml,*.html,*.css,*.less,*.sass :lua vim.lsp.buf.formatting_sync(nil, 200)<CR>
-- ]]
