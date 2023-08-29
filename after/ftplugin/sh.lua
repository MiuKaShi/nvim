vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.opt_local.formatoptions = vim.opt_local.formatoptions - { "c", "r", "o" }


-- pipe textobj
--stylua: ignore
vim.keymap.set({ "o", "x" }, "i|", "<cmd>lua require('various-textobjs').shellPipe(true)<CR>", { desc = "󱡔 inner shellPipe textobj", buffer = true })
--stylua: ignore
vim.keymap.set({ "o", "x" }, "a|", "<cmd>lua require('various-textobjs').shellPipe(false)<CR>", { desc = "󱡔 outer shellPipe textobj", buffer = true })
