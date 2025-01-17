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
map({ "i", "c" }, "<C-a>", "<Home>")
map({ "i", "c" }, "<C-e>", "<End>")
map("n", "i", function()
  if vim.api.nvim_get_current_line():find "^%s*$" then return [["_cc]] end
  return "i"
end, { desc = "correctly indented i", expr = true })

-- better i
map("n", "i", function()
  if vim.api.nvim_get_current_line():find "^%s*$" then return [["_cc]] end
  return "i"
end, { expr = true, desc = "better i" })

-------------
-- normal mode
-------------

-- Delete trailing character
map("n", "X", function()
  local updatedLine = vim.api.nvim_get_current_line():gsub("%s+$", ""):sub(1, -2)
  vim.api.nvim_set_current_line(updatedLine)
end, { desc = "󱎘 Delete char at EoL" })

-- buffer
map("n", "<A-Tab>", "<cmd>bnext<CR>") -- buffer 跳转
map("n", "<leader>bc", "<cmd>bd<CR>") -- buffer 关闭
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>")

-- paste without yanking
map({ "x" }, "p", "P", { silent = true })

-- better movement
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "H", "0^")
map("o", "H", "^")
map({ "n", "v", "o" }, "L", "$zv")

-- quickfix
map("n", "gq", vim.cmd.cnext, { desc = " Next Quickfix" })
map("n", "gQ", vim.cmd.cprevious, { desc = " Prev Quickfix" })
map("n", "dQ", function() vim.cmd.cexpr "[]" end, { desc = " Clear Quickfix List" })

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
map({ "n", "v" }, "<Leader>;", "gcc", { desc = " Comment Line", remap = true })

-- resize split window
map("n", "<Leader>=", "10<C-w>+")
map("n", "<Leader>-", "10<C-w>-")
map("n", "<Leader>[", "10<C-w><")
map("n", "<Leader>]", "10<C-w>>")

-- Whitespace control
map("n", "=", "mzO<Esc>`z", { desc = "  blank above" })
map("n", "_", "mzo<Esc>`z", { desc = "  blank below" })
map("n", "<Tab>", ">>", { desc = "󰉶 indent line" })
map("n", "<S-Tab>", "<<", { desc = "󰉵 outdent line" })
map("x", "<Tab>", ">gv", { desc = "󰉶 indent selection" })
map("x", "<S-Tab>", "<gv", { desc = "󰉵 outdent selection" })
map("i", "<S-Tab>", "<C-d>", { desc = "󰉵 outdent line" })
map("i", "<Tab>", "<C-t>", { desc = "󰉵 indent line" })

-- Close all top-level folds
map("n", "zx", "<cmd>%foldclose<CR>", { desc = "󰘖 Close toplevel folds" })

-- Fix spelling
map("n", "z.", "1z=", { desc = "󰓆 Fix Spelling" })
-- Move selection right
map("x", "<Right>", [["zx"zpgvlolo]])
map("x", "<Left>", [["zdh"zPgvhoho]])

-- Merging
map({ "n", "x" }, "M", "J", { desc = "󰗈 Merge up" })
map({ "n", "x" }, "gm", '"zdd"zpkJ', { desc = "󰗈 Merge down" })

-- vim-bookmarks
-- map("n", "mm", "<cmd>BookmarkToggle<CR>")
-- map("n", "mn", "<cmd>BookmarkNext<CR>")
-- map("n", "mp", "<cmd>BookmarkPrev<CR>")
-- map("n", "mc", "<cmd>BookmarkClear<CR>")

map("n", "<leader><leader>s", "<cmd>w ! sudo tee > /dev/null %<CR>") -- force save files

-- command line mode
map({ "i", "c" }, "<C-a>", "<Home>")
map({ "i", "c" }, "<C-e>", "<End>")
map("c", "<BS>", function()
  if vim.fn.getcmdline() ~= "" then return "<BS>" end
end, { desc = "Restricted <BS>", expr = true })

-- quick comment
map("n", "wq", function() util.duplicateAsComment() end, { desc = " Duplicate Line as Comment" })
map("n", "qn", function() util.insertDoublePercentCom() end, { desc = " Insert %% Comment" })
map("n", "dN", function() util.removeDoublePercentComs() end, { desc = " Remove %% Comments" })

-- flip word
map("n", "<leader>t", function() require("util.flipper").flipWord() end, { desc = "switch common words" })

-- better gx
map("", "gx", '<Cmd>call jobstart(["linkhandler", expand("<cfile>")], {"detach": v:true})<CR>', {})

-- bib
vim.cmd [[autocmd FileType markdown.pandoc inoremap <buffer> <silent> @@ <Esc>:BibtexciteInsert<CR>]]

-- emulate some basic commands from `vim-abolish`
map("n", "crt", "mzguiwgUl`z", { desc = "󰬴 Titlecase" })
map("n", "cru", "mzgUiw`z", { desc = "󰬴 UPPERCASE" })
map("n", "crl", "mzguiw`z", { desc = "󰬴 lowercase" })

-- LINE & CHARACTER MOVEMENT
map("n", "<Down>", [[<cmd>. move +2<CR>==]], { desc = "󰜮 Move line down" })
map("n", "<Up>", [[<cmd>. move -2<CR>==]], { desc = "󰜷 Move line up" })
map("n", "<Right>", [["zx"zp]], { desc = "➡️ Move char right" })
map("n", "<Left>", [["zdh"zph]], { desc = "⬅ Move char left" })
map("x", "<Down>", [[:move '>+1<CR>gv=gv]], { desc = "󰜮 Move selection down", silent = true })
map("x", "<Up>", [[:move '<-2<CR>gv=gv]], { desc = "󰜷 Move selection up", silent = true })
map("x", "<Right>", [["zx"zpgvlolo]], { desc = "➡️ Move selection right" })
map("x", "<left>", [["zdh"zpgvhoho]], { desc = "⬅ Move selection left" })

-- toggle options
map("n", "~", function() util.toggleCase() end, { desc = "better ~" })
map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle Word Wrap" })
map("n", "<leader>uh", function() util.toggle_inlay_hints() end, { desc = "Toggle Inlay Hints" })
map("n", "<leader>ut", function() vim.cmd.TSBufToggle "highlight" end, { desc = "Treesitter highlights" })
map("n", "<leader>i", function() util.toggle_spellcheck() end, { desc = "Toggle Spelling" })
map("n", "<leader>.", function() util.toggle_diagnostics() end, { desc = "Toggle   Diagnostics" })
map("n", "<leader>ul", function()
  vim.notify("LSP Restarting…", vim.log.levels.WARN)
  vim.cmd.LspRestart()
end, { desc = "󰒕 :LspRestart" })
map(
  "n",
  "<leader>uo",
  function() vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0 end,
  { desc = "󰈉 Conceal" }
)
