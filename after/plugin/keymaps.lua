local util = require "util"

local function map(mode, shortcut, command, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, shortcut, command, opts)
end

-------------
-- insert mode
-------------

map("i", "<C-a>", "<Esc>0i")
map("i", "<C-e>", "<End>")

-------------
-- normal mode
-------------

-- buffer
map("n", "<A-Tab>", "<cmd>bnext<CR>") -- buffer 跳转
map("n", "<leader>bc", "<cmd>bd<CR>") -- buffer 关闭
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>")

-- paste without yanking
map({ "x" }, "p", "P", { silent = true })

-- better movement
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v", "o" }, "H", "^", { desc = "Use 'H' as '^'" })
map({ "n", "v", "o" }, "L", "$", { desc = "Use 'L' as '$'" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<", "v<g")
map("n", ">", "v>g")

-- visual move
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- split window
map("n", "<Leader>s", "<cmd>sp<CR>")
map("n", "<Leader>v", "<cmd>vsp<CR>")
map("n", "<Leader>h", "<C-w>h")
map("n", "<Leader>l", "<C-w>l")
map("n", "<Leader>j", "<C-w>j")
map("n", "<Leader>k", "<C-w>k")

-- toggle comment

vim.cmd [[nmap <leader>; gcc<esc>]]
vim.cmd [[vmap <leader>; gcc<esc>]]

-- resize split window
map("n", "<Leader>=", "10<C-w>+")
map("n", "<Leader>-", "10<C-w>-")
map("n", "<Leader>[", "10<C-w><")
map("n", "<Leader>]", "10<C-w>>")

-- vim-bookmarks
-- map("n", "mm", "<cmd>BookmarkToggle<CR>")
-- map("n", "mn", "<cmd>BookmarkNext<CR>")
-- map("n", "mp", "<cmd>BookmarkPrev<CR>")
-- map("n", "mc", "<cmd>BookmarkClear<CR>")

map("n", "<leader>i", "<cmd>setlocal spell! spelllang=en_us<CR>") -- spell check

map("n", "<leader>hn", "<cmd>nohl<CR>") -- disable highlight
map("n", "<leader><leader>s", "<cmd>w ! sudo tee > /dev/null %<CR>") -- force save files

-- command line mode
map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")
map("c", "<C-h>", "<BS>")
map("c", "<C-k>", "<C-f>D<C-c><C-c>:<Up>")

-- flip word
map("n", "<leader>t", function() require("util.flipper").flipWord() end, { desc = "switch common words / toggle casing" })

-- better gx
map("", "gx", '<Cmd>call jobstart(["linkhandler", expand("<cfile>")], {"detach": v:true})<CR>', {})

-- bib
vim.cmd [[autocmd FileType markdown.pandoc inoremap <buffer> <silent> @@ <Esc>:BibtexciteInsert<CR>]]

-- toggle options
map("n", "<leader>us", function() util.toggle "spell" end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() util.toggle "wrap" end, { desc = "Toggle Word Wrap" })
map("n", "<leader>.", util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map(
  "n",
  "<leader>ul",
  function() util.toggle("conceallevel", false, { 0, conceallevel }) end,
  { desc = "Toggle Conceal" }
)
