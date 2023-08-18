vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.wo.conceallevel = 2
vim.bo.expandtab = true
vim.bo.spelllang = "en_us,cjk"

-- pandoc sytanx setting
vim.g["pandoc#syntax#conceal#blacklist"] = {
  "atx",
  "ellipses",
  "emdashes",
  "codeblock_start",
  "codeblock_delim",
}
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

-- stylua: ignore start
vim.keymap.set("n", "<leader>p", "<cmd>MarkdownPreviewToggle<CR>") -- 预览
vim.keymap.set("n", "<leader>cc", ":!compiler <c-r>%<CR><CR>")
vim.keymap.set("n", "<leader>cp", '<Cmd>call jobstart(["autoprev", expand("%:p")])<CR>')


vim.keymap.set("n", "<C-b>", "bi**<Esc>ea**<Esc>", { buffer = 0 })
vim.keymap.set("v", "<C-b>", ":lua require('markdowny').bold()<cr>", { buffer = 0 })

vim.keymap.set("n", "<C-e>", "bi_<Esc>ea_<Esc>", { buffer = 0 })
vim.keymap.set("v", "<C-e>", ":lua require('markdowny').italic()<cr>", { buffer = 0 })

vim.keymap.set("n", "<C-l>", "bi[<Esc>ea]()<Esc>hp", { buffer = 0 })
vim.keymap.set("v", "<C-l>", ":lua require('markdowny').link()<cr>", { buffer = 0 })

vim.keymap.set("v", "<C-c>", ":lua require('markdowny').code()<cr>", { buffer = 0 })

--text-obj
vim.keymap.set({ "o", "x" }, "il", "<cmd>lua require('various-textobjs').mdlink(true)<CR>", { desc = "inner md link textobj", buffer = true })
vim.keymap.set({ "o", "x" }, "al", "<cmd>lua require('various-textobjs').mdlink(false)<CR>", { desc = "outer md link textobj", buffer = true })

-- ic/ac: code block textobj
vim.keymap.set({ "o", "x" }, "ic", "<cmd>lua require('various-textobjs').mdFencedCodeBlock(true)<CR>", { desc = "inner md code block textobj", buffer = true })
vim.keymap.set({ "o", "x" }, "ac", "<cmd>lua require('various-textobjs').mdFencedCodeBlock(false)<CR>", { desc = "outer md code block textobj", buffer = true })
