vim.g.mapleader = ' '

local set_keymap = vim.api.nvim_set_keymap

local function _map(mode, shortcut, command)
    set_keymap(mode, shortcut, command, { noremap = true, silent = true })
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

-- Setup for emacs keybindings
-- insert mode
set_keymap('i', '<C-a>', '<Esc>0i', {})
set_keymap('i', '<C-e>', '<End>', {})
set_keymap('i', '<C-d>', '<Del>', {})
set_keymap('i', '<C-c>', '<C-r>=KillLine()<CR>', {})
set_keymap('i', '<C-n>', '<Plug>(fzf-complete-wordnet)', {}) -- dicitonal

-- normal mode
set_keymap('n', '<C-l>', ':bnext<CR>', {}) -- buffer 跳转
set_keymap('n', '<C-h>', ':bprev<CR>', {})
set_keymap('n', '<C-s>', ':w<CR>', {}) -- save file
set_keymap('n', '<C-e>', ':Lf<CR>', {}) -- file tree
set_keymap('n', '<C-w>', ':bdelete<CR>', {}) -- file tree
set_keymap('n', 'j', 'gj', {}) -- gj
set_keymap('n', 'k', 'gk', {}) -- gk
-- set_keymap('n', 's', '<Plug>(easymotion-overwin-f)', {})
set_keymap('n', '<leader>;;', 'gcc', {})
set_keymap('v', '<leader>;', 'gcc<esc>', {})

-- command line mode
set_keymap('c', '<C-a>', '<Home>', {})
set_keymap('c', '<C-e>', '<End>', {})
-- C-d 本身表示显示详情，可用命令
-- set_keymap('c', '<C-d>', '<Del>', {})
set_keymap('c', '<C-h>', '<BS>', { noremap = true })
set_keymap('c', '<C-k>', '<C-f>D<C-c><C-c>:<Up>', { noremap = true })
-- End of setup for emacs keybindings

-- lspconfig 服务地址 https://github.com/neovim/nvim-lspconfig
nmap('gd',         '<cmd>lua vim.lsp.buf.definition()<CR>') -- 跳转定义
nmap('J',          "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>") -- 预览定义
nmap('K',          "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>") -- 显示文档定义
nmap('<C-n>',      "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>") -- 滚动hover 下
nmap('<C-p>',      "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>") -- 滚动hover 上
nmap('<C-f>',      '<cmd>Telescope find_files<CR>') -- 查找文件
nmap('gF',         ':Telescope live_grep<CR>') -- 模糊查找文件
nmap('gs',         "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>") -- 签名查看
nmap('gS',         "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>") -- 诊断问题
nmap('gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>') -- 跳转实现
nmap('gn',         ':BufferLineCycleNext<CR>') -- 下一个文件
nmap('gp',         ':BufferLineCyclePrev<CR>') -- 上一个文件
nmap('gr',         "<cmd>lua require('lspsaga.rename').rename()<CR>") -- 重命名变量
nmap('ca',         "<cmd>lua require('lspsaga.codeaction').code_action()<CR>") -- 代码操作
vmap('ca',         ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>") -- 选中的代码操作
nmap('gh',         "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>") -- 异步查找单词定义、引用
tmap('<ESC>',      '<C-\\><C-n>:Lspsaga close_floaterm<CR>') -- 关闭终端

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
        f = { '<cmd>lua vim.lsp.buf.formatting_sync(nil, 200)<cr>', 'Format' },
        c = { '<cmd>BibtexciteInsert<CR>', 'Bib citation insert' },
        v = { '<cmd>BibtexciteShowcite<CR>', 'Bib citation view' },
        o = { '<cmd>BibtexciteOpenfile<CR>', 'Bib Open pdf' },
    },
    ['f']       = {
        name = '+Files',
        f = { "<cmd> lua require('telescope.builtin').builtin()<CR>", 'current working directory' },
        r = { '<cmd>Telescope oldfiles<CR>', 'Open recent file', noremap = false },
        w = { '<cmd>Telescope grep_string theme=ivy<CR>', 'Find cursor word' },
        s = { '<cmd>w ! sudo tee > /dev/null %<CR>', 'Force save file' },
        t = { "<cmd> lua require('telescope.builtin').treesitter()<CR>", 'trees of functions/variables' },
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
        name = '+Search/Symbols',
        e = { ':Lspsaga rename<CR>', 'Edit symbol' },
        s = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find { fuzzy = false,  case_mode = 'ignore_case' }<cr>", 'Search current buffer' },
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
    o           = { ':AerialToggle<CR>', 'Outline' }, -- Outline
    ['*']       = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", 'Search reference in current project' }, -- lsp 查找引用
    ['/']       = { ':Telescope live_grep<CR>', 'Fuzzy search in project' }, -- 项目内查找
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
