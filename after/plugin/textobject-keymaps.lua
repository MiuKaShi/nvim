local keymap = vim.keymap.set
local cmd = vim.cmd
local u = require "util"

--------------------------------------------------------------------------------
-- REMAPPING OF BUILTIN TEXT OBJECTS
for remap, original in pairs(u.textobjectRemaps) do
  keymap({ "o", "x" }, "i" .. remap, "i" .. original, { desc = "󱡔 inner " .. original })
  keymap({ "o", "x" }, "a" .. remap, "a" .. original, { desc = "󱡔 outer " .. original })
end

-- QUICK TEXTOBJ OPERATIONS
keymap("n", "<Space>", '"_ciw', { desc = "󱡔 change word" })
keymap("x", "<Space>", '"_c', { desc = "󱡔 change selection" })
keymap("n", "<S-Space>", '"_daw', { desc = "󱡔 delete word" })

--------------------------------------------------------------------------------

-- VARIOUS TEXTOBJS KEYMAPS

-- stylua: ignore start
-- space: subword
keymap("o", "<Space>", "<cmd>lua require('various-textobjs').subword('inner')<CR>", { desc = "󱡔 inner subword textobj" })
keymap({"o", "x"}, "i<Space>", "<cmd>lua require('various-textobjs').subword('inner')<CR>", { desc = "󱡔 inner subword textobj" })
keymap({"o", "x"}, "a<Space>", "<cmd>lua require('various-textobjs').subword('outer')<CR>", { desc = "󱡔 outer subword textobj" })

-- L: link
keymap("o", "L", "<cmd>lua require('various-textobjs').url()<CR>", { desc = "󱡔 link textobj" })

-- iv/av: value textobj
keymap({ "x", "o" }, "iv", "<cmd>lua require('various-textobjs').value('inner')<CR>", { desc = "󱡔 inner value textobj" })
keymap({ "x", "o" }, "av", "<cmd>lua require('various-textobjs').value('outer')<CR>", { desc = "󱡔 outer value textobj" })

-- ak: outer key textobj
keymap({ "x", "o" }, "ak", "<cmd>lua require('various-textobjs').key('inner')<CR>", { desc = "󱡔 outer key textobj" })

-- n: [n]ear end of the line
keymap({ "o", "x" }, "n", "<cmd>lua require('various-textobjs').nearEoL()<CR>", { desc = "󱡔 near EoL textobj" })

-- m: to next closing bracket
-- w: to next quotation mark
keymap({ "o", "x" }, "m", "<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>", { desc = "󱡔 to next closing bracket textobj" })
keymap("o", "w", "<cmd>lua require('various-textobjs').toNextQuotationMark()<CR>", { desc = "󱡔 to next quote textobj", nowait = true })

-- o: c[o]lumn textobj
keymap({"x", "o"}, "O", "<cmd>lua require('various-textobjs').column()<CR>", { desc = "󱡔 column textobj" })

-- an/in: number
keymap({"x", "o"}, "in", "<cmd>lua require('various-textobjs').number('inner')<CR>", { desc = "󱡔 inner number textobj" })
keymap({"x", "o"}, "an", "<cmd>lua require('various-textobjs').number('outer')<CR>", { desc = "󱡔 outer number textobj" })

-- gg: entire buffer textobj
keymap({ "x", "o" }, "gg", "<cmd>lua require('various-textobjs').entireBuffer()<CR>", { desc = "󱡔 entire buffer textobj" })

-- v: viewport
keymap("o" , "v", "<cmd>lua require('various-textobjs').visibleInWindow()<CR>", { desc = "󱡔 visible in window textobj" })

-- r: [r]est of …
-- INFO not setting in visual mode, to keep visual block mode replace
keymap("o", "rv", "<cmd>lua require('various-textobjs').restOfWindow()<CR>", { desc = "󱡔 rest of viewport textobj" })
keymap("o", "rp", "<cmd>lua require('various-textobjs').restOfParagraph()<CR>", { desc = "󱡔 rest of paragraph textobj" })
keymap("o", "ri", "<cmd>lua require('various-textobjs').restOfIndentation()<CR>", { desc = "󱡔 rest of indentation textobj" })
keymap("o", "rg", "G", { desc = "󱡔 rest of buffer textobj" })

-- ge: diagnostic textobj (similar to ge for the next diagnostic)
keymap({ "x", "o" }, "ge", "<cmd>lua require('various-textobjs').diagnostic()<CR>", { desc = "󱡔 diagnostic textobj" })


-- ai/ag/aj: indentation textobjs
keymap({ "x", "o" }, "ii", "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>", { desc = "󱡔 inner indent textobj" })
keymap({ "x", "o" }, "ai", "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>", { desc = "󱡔 outer indent textobj" })
keymap({ "x", "o" }, "ij", "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>", { desc = "󱡔 top-border indent textobj" })
keymap({ "x", "o" }, "aj", "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>", { desc = "󱡔 top-border indent textobj" })
keymap({ "x", "o" }, "ig", "<cmd>lua require('various-textobjs').greedyOuterIndentation('inner')<CR>", { desc = "󱡔 inner greedy indent" })
keymap({ "x", "o" }, "ag", "<cmd>lua require('various-textobjs').greedyOuterIndentation('outer')<CR>", { desc = "󱡔 outer greedy indent" })

-- i./a.: chain-member
keymap({ "x", "o" }, "i.", "<cmd>lua require('various-textobjs').chainMember('inner')<CR>", { desc = "󱡔 inner indent textobj" })
keymap({ "x", "o" }, "a.", "<cmd>lua require('various-textobjs').chainMember('outer')<CR>", { desc = "󱡔 outer indent textobj" })
