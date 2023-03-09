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
nmap('j', 'gj')
nmap('k', 'gk')

-- vim-bookmarks
nmap('mm', '<cmd>BookmarkToggle<CR>')
nmap('mn', '<cmd>BookmarkNext<CR>')
nmap('mp', '<cmd>BookmarkPrev<CR>')
nmap('mc', '<cmd>BookmarkClear<CR>')

nmap('<leader>t', ':Lf<CR>') -- finder
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
