vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.scrolloff = 10

-- hide links and some markup (similar to Obsidian's live preview)
vim.opt_local.conceallevel = 2

vim.opt_local.expandtab = true
vim.opt_local.spelllang = { "en_us", "cjk" }

-- decrease line length without zen mode plugins
-- vim.opt_local.signcolumn = "yes:9"

-- do not auto-wrap text
vim.opt_local.formatoptions:remove { "t", "c" }

-- pandoc sytanx setting
vim.g["pandoc#syntax#conceal#blacklist"] = {
  "titleblock",
  "image",
  "block",
  "strikeout",
  "footnote",
  "quotes",
  "ellipses",
  "dashes",
  "atx",
  "ellipses",
  "emdashes",
  "codeblock_start",
  "codeblock_delim",
}
vim.g["pandoc#syntax#conceal#cchar_overrides"] = { atx = "#" }
vim.g["pandoc#syntax#style#emphases"] = 0
vim.g["pandoc#syntax#style#underline_special"] = 0
vim.g["pandoc#modules#disabled"] = {
  "folding",
  "toc",
  "templates",
  "yaml",
  "formatting",
  "keyboard",
  "executors",
  "bibliographies",
  "spell",
  "hypertext",
  "menu",
}
vim.g["pandoc#syntax#style#use_definition_lists"] = 0

vim.g.tex_conceal = "amgs" --disable equation conceal
vim.g["pandoc#syntax#codeblocks#embeds#langs"] =
  { "python", "bash=sh", "c", "cpp", "latex=tex", "diff", "julia", "rust" }

vim.cmd [[
hi pandocEmphasis     guibg=NONE guifg=#689d6a gui=italic cterm=italic
hi pandocStrong       guibg=NONE guifg=#d79921 gui=bold cterm=bold
hi pandocStrongEmphasis gui=bold,italic cterm=bold,italic
hi pandocStrongInEmphasis gui=bold,italic cterm=bold,italic
hi pandocEmphasisInStrong gui=bold,italic cterm=bold,italic
]]

-- 保存时自动格式化 markdown
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.markdown", "*.md", "*.text", "*.txt" },
  command = "PanguAll",
  -- nested = true,
})

-- stylua: ignore start
vim.keymap.set("n", "<leader>p", "<cmd>MarkdownPreviewToggle<CR>") -- 预览
vim.keymap.set("n", "<leader>cc", ":!compiler <c-r>%<CR><CR>")
vim.keymap.set("n", "<leader>cp", '<Cmd>call jobstart(["autoprev", expand("%:p")])<CR>')
vim.keymap.set("n", "<leader>tt", "vip:!pandoc -t commonmark_x<CR><CR>",{ desc = " Format Table under Cursor", buffer = true })

vim.keymap.set("n", "<leader>x", "mzI- [ ] <Esc>`z", { desc = " Add Task", buffer = true })
vim.keymap.set("n", "<leader>-", "mzI- <Esc>`z", { desc = " Add List", buffer = true })

vim.keymap.set("n", "<C-b>", "bi**<Esc>ea**<Esc>", { buffer = 0 })
vim.keymap.set("v", "<C-b>", ":lua require('markdowny').bold()<cr>", { buffer = 0 })
vim.keymap.set("i", "<C-b>", "****<Left><Left>", { buffer = 0 })

vim.keymap.set("n", "<C-e>", "bi_<Esc>ea_<Esc>", { buffer = 0 })
vim.keymap.set("v", "<C-e>", ":lua require('markdowny').italic()<cr>", { buffer = 0 })

vim.keymap.set("n", "<C-l>", "bi[<Esc>ea]()<Esc>hp", { buffer = 0 })
vim.keymap.set("v", "<C-l>", ":lua require('markdowny').link()<cr>", { buffer = 0 })
vim.keymap.set("i", "<C-l>", "[]()<Left><Left><Left>", { buffer = true })

vim.keymap.set("v", "<C-c>", ":lua require('markdowny').code()<cr>", { buffer = 0 })

-- Heading jump to next/prev heading
vim.keymap.set({ "n", "x" }, "<C-j>", [[/^#\+ <CR><cmd>nohl<CR>]], { desc = " # Next Heading", buffer = true })
vim.keymap.set({ "n", "x" }, "<C-k>", [[?^#\+ <CR><cmd>nohl<CR>]], { desc = " # Prev Heading", buffer = true })
