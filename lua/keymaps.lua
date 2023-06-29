--[[
Description: file content
Author: Zhang Ke
Date: 2023-05-10 16:07:57
LastEditors: Zhang Ke
LastEditTime: 2023-05-10 16:10:57
--]]
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

-------------
-- insert mode
-------------

imap('<C-a>', '<Esc>0i')
imap('<C-e>', '<End>')
imap('<C-n>', '<Plug>(fzf-complete-wordnet)')

-------------
-- normal mode
-------------

-- buffer
nmap('<C-l>', '<cmd>bnext<CR>') -- buffer 跳转
nmap('<C-h>', '<cmd>bprev<CR>')
nmap('<C-s>', '<cmd>write<CR>')

-- better up/down
-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- split window
nmap('<Leader>s', ':sp<CR>')
nmap('<Leader>v', ':vsp<CR>')
nmap('<Leader>h', '<C-w>h')
nmap('<Leader>l', '<C-w>l')
nmap('<Leader>j', '<C-w>j')
nmap('<Leader>k', '<C-w>k')

-- resize split window
nmap('<Leader>=', '10<C-w>+')
nmap('<Leader>-', '10<C-w>-')
nmap('<Leader>[', '10<C-w><')
nmap('<Leader>]', '10<C-w>>')

-- vim-bookmarks
nmap('mm', '<cmd>BookmarkToggle<CR>')
nmap('mn', '<cmd>BookmarkNext<CR>')
nmap('mp', '<cmd>BookmarkPrev<CR>')
nmap('mc', '<cmd>BookmarkClear<CR>')

nmap('<leader>lf', ':Lf<CR>') -- finder
nmap('<leader>i', '<cmd>setlocal spell! spelllang=en_us<CR>') -- spell check
nmap('<leader>o', ':AerialToggle<CR>') -- Outlines
nmap('<leader>.', ':call ToggleHiddenAll()<CR>') -- LSP 开关

nmap('<leader>hn', ':nohl<CR>') -- disable highlight
nmap('<leader>ss', '<cmd>w ! sudo tee > /dev/null %<CR>') -- force save files

nmap('<leader>gd', '<cmd>DiffviewOpen<CR>')
nmap('<leader>gx', '<cmd>DiffviewClose<CR>')

nmap('<leader>cc', ':!compiler <c-r>%<CR><CR>')
nmap('<leader>cp', '<Cmd>call jobstart(["autoprev", expand("%:p")])<CR>')

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
