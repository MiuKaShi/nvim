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
nmap('<leader>;;', 'gcc')
vmap('<leader>;', 'gcc<esc>')

-- command line mode
cmap('<C-a>', '<Home>')
cmap('<C-e>', '<End>')
cmap('<C-h>', '<BS>')
cmap('<C-k>', '<C-f>D<C-c><C-c>:<Up>')

nmap('gn', ':BufferLineCycleNext<CR>') -- 下一个文件
nmap('gp', ':BufferLineCyclePrev<CR>') -- 上一个文件
-- End of setup for emacs keybindings

-- better gx mapping
local function gmap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

gmap('', 'gx', '<Cmd>call jobstart(["linkhandler", expand("<cfile>")], {"detach": v:true})<CR>', {})
