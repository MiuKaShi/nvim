vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
nmap('j', 'gj')
nmap('k', 'gk')
nmap('gn', ':BufferLineCycleNext<CR>') -- 下一个文件
nmap('gp', ':BufferLineCyclePrev<CR>') -- 上一个文件
nmap('<leader>/', ':Telescope live_grep previewer=false <CR>') -- fuzzy_find
nmap('<leader><Space>', ':Lf<CR>') -- finder
nmap('<leader>o', ':AerialToggle<CR>') -- Outlines
nmap('<leader>l', ':call ToggleHiddenAll()<CR>') -- LSP 开关
nmap('<leader>t', ':Lspsaga open_floaterm<CR>') -- 打开终端
nmap('<leader>nh', ':nohl<CR>') -- disable highlight

nmap('<leader>a', ':EasyAlign<CR>') -- EasyAlign
vmap('<leader>a', ':EasyAlign<CR>') -- EasyAlign

-- nmap(']l', ':ObsidianFollowLink<CR>') -- follow link
-- nmap('[l', ':ObsidianBacklinks<CR>') -- back link
-- nmap('lo', ':ObsidianOpen<CR>') -- link open

-- command line mode
cmap('<C-a>', '<Home>')
cmap('<C-e>', '<End>')
cmap('<C-h>', '<BS>')
cmap('<C-k>', '<C-f>D<C-c><C-c>:<Up>')

-- End of setup for keybindings

-- better gx mapping
local function gmap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

gmap('', 'gx', '<Cmd>call jobstart(["linkhandler", expand("<cfile>")], {"detach": v:true})<CR>', {})
