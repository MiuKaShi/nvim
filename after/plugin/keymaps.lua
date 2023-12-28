local util = require "util"

local function map(mode, shortcut, command, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, shortcut, command, opts)
end

-- search keymaps
map("n", "?", function() vim.cmd.Telescope "keymaps" end, { desc = "⌨️  Search Keymaps" })

-------------
-- insert mode
-------------
map("i", "<C-a>", "<Esc>0i")
map("i", "<C-e>", "<End>")

-- better i
map("n", "i", function()
  if vim.api.nvim_get_current_line():find "^%s*$" then return [["_cc]] end
  return "i"
end, { expr = true, desc = "better i" })

-------------
-- normal mode
-------------

--Delete char at EoL
map("n", "X", "mz$x`z")

-- buffer
map("n", "<A-Tab>", "<cmd>bnext<CR>") -- buffer 跳转
map("n", "<leader>bc", "<cmd>bd<CR>") -- buffer 关闭
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>")

-- paste without yanking
map({ "x" }, "p", "P", { silent = true })

-- better movement
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v", "o" }, "H", "^")
map({ "n", "v", "o" }, "L", "$")

-- paragraph-wise movement
map({ "n", "x" }, "gk", "{gk")
map({ "n", "x" }, "gj", "}gj")

-- SEARCH
map("n", "+", "*", { desc = "Search word under cursor" })
map("x", "+", [["zy/\V<C-R>=getreg("@z")<CR><CR>]], { desc = "* Visual Star" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<", "v<g")
map("n", ">", "v>g")

-- visual move
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>ws", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>wv", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>wo", "<C-W>o", { desc = "Close other window" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
map("i", "=", "=<c-g>u")

-- toggle comment

vim.cmd [[nmap <leader>; gcc<esc>]]
vim.cmd [[vmap <leader>; gcc<esc>]]

-- resize split window
map("n", "<Leader>=", "10<C-w>+")
map("n", "<Leader>-", "10<C-w>-")
map("n", "<Leader>[", "10<C-w><")
map("n", "<Leader>]", "10<C-w>>")

-- Whitespace control
map("n", "=", "mzO<Esc>`z", { desc = "  blank above" })
map("n", "_", "mzo<Esc>`z", { desc = "  blank below" })
map("n", "<Tab>", ">>", { desc = "󰉶 indent" })
map("n", "<S-Tab>", "<<", { desc = "󰉵 outdent" })
map("x", "<Tab>", ">gv", { desc = "󰉶 indent" })
map("x", "<S-Tab>", "<gv", { desc = "󰉵 outdent" })
map("n", "X", "mz$x`z", { desc = "Delete char at EoL" })

-- Fix spelling
map("n", "z.", "1z=")
-- Move selection right
map("x", "<Right>", [["zx"zpgvlolo]])
map("x", "<Left>", [["zdh"zPgvhoho]])

-- vim-bookmarks
-- map("n", "mm", "<cmd>BookmarkToggle<CR>")
-- map("n", "mn", "<cmd>BookmarkNext<CR>")
-- map("n", "mp", "<cmd>BookmarkPrev<CR>")
-- map("n", "mc", "<cmd>BookmarkClear<CR>")

map("n", "<leader><leader>s", "<cmd>w ! sudo tee > /dev/null %<CR>") -- force save files

-- command line mode
map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")
map("c", "<C-h>", "<BS>")
map("c", "<C-k>", "<C-f>D<C-c><C-c>:<Up>")


-- quick comment
map("n", "wq", function() util.duplicateAsComment() end, { desc = " Duplicate Line as Comment" })

-- flip word
map("n", "<leader>t", function() require("util.flipper").flipWord() end, { desc = "switch common words" })

-- better gx
map("", "gx", '<Cmd>call jobstart(["linkhandler", expand("<cfile>")], {"detach": v:true})<CR>', {})

-- bib
vim.cmd [[autocmd FileType markdown.pandoc inoremap <buffer> <silent> @@ <Esc>:BibtexciteInsert<CR>]]

-- toggle options
map("n", "~", function() util.toggleCase() end, { desc = "better ~" })
map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle Word Wrap" })
map("n", "<leader>uh", function() util.inlay_hints() end, { desc = "Toggle Inlay Hints" })
map("n", "<leader>i", function() util.toggle_spellcheck() end, { desc = "Toggle Spelling" })
map("n", "<leader>.", function() util.toggle_diagnostics() end, { desc = "Toggle   Diagnostics" })
