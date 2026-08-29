local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  desc = "User: Restore cursor position",
  callback = function(ctx)
    if vim.bo[ctx.buf].buftype ~= "" then return end
    vim.cmd [[silent! normal! g`"]]
  end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("resize_splits", {}),
  command = "wincmd =",
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank { higroup = "IncSearch", timeout = 250, on_visual = true } end,
  pattern = "*",
})

-- Fixing cursor
autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    vim.opt.guicursor = vim.opt.guicursor + { "a:block-blink100" } -- Block cursor
  end,
})

-- simplified version of https://github.com/Aasim-A/scrollEOF.nvim
autocmd({ "CursorMoved", "BufReadPost" }, {
  desc = "User: Enforce scrolloff at EoF",
  callback = function(ctx)
    if vim.bo[ctx.buf].buftype ~= "" then return end

    local winHeight = vim.api.nvim_win_get_height(0)
    local visualDistanceToEof = winHeight - vim.fn.winline()
    local scrolloff = math.min(vim.o.scrolloff, math.floor(winHeight / 2))

    if visualDistanceToEof < scrolloff then
      local topline = vim.fn.winsaveview().topline
      -- topline is inaccurate if it is a folded line, thus add number of folded lines
      local toplineFoldAmount = vim.fn.foldclosedend(topline) - vim.fn.foldclosed(topline)
      topline = topline + toplineFoldAmount
      vim.fn.winrestview { topline = topline + scrolloff - visualDistanceToEof }
    end
  end,
})

-- For suckless
autocmd({ "BufWritePost" }, {
  pattern = ".Xresources",
  callback = function()
    vim.cmd "!xrdb %"
    vim.cmd "!pidof st | xargs kill -s USR1"
  end,
  desc = "Reload st terminal",
})

-- close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q", {}),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "vim",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

-- automatically disable search highlight
local smart_hl = augroup("smart_hl", { clear = true })
local function stop_hl()
  if vim.v.hlsearch == 0 then return end
  local keycode = vim.api.nvim_replace_termcodes("<Cmd>nohl<CR>", true, false, true)
  vim.api.nvim_feedkeys(keycode, "n", false)
end
local function start_hl()
  local res = vim.fn.getreg "/"
  if vim.v.hlsearch == 1 and vim.fn.search([[\%#\zs]] .. res, "cnW") == 0 then stop_hl() end
end

autocmd("InsertEnter", {
  group = smart_hl,
  callback = function() stop_hl() end,
  desc = "Auto remove hlsearch",
})
-- autocmd("CursorMoved", {
--   group = smart_hl,
--   callback = function() start_hl() end,
--   desc = "Auto hlsearch",
-- })

-- For suckless st
autocmd({ "BufWritePost" }, {
  pattern = ".Xresources",
  callback = function()
    vim.cmd "!xrdb %"
    vim.cmd "!pidof st | xargs kill -s USR1"
  end,
  desc = "Reload st terminal",
})

-- close ai
-- autocmd("BufEnter", {
--   pattern = { "*.markdown", "*.md", "*.geo", "*.text", "*.txt" },
--   callback = function()
--     if require("supermaven-nvim.api").is_running() then vim.cmd "SupermavenStop" end
--   end,
-- })

-- 保存时自动使用panguALL格式化 markdown
autocmd("BufWritePre", {
  pattern = { "*.markdown", "*.md", "*.text", "*.txt" },
  command = "PanguAll",
})

-- For colorscheme that don't support transparency. Set transparent_nvim value in options.lua.
if vim.g.transparent_nvim then
  autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      local hl_group = {
        "Normal",
        "NonText",
        "LineNr",
        "SignColumn",
        "MsgArea",
        "Pmenu",
        "WhichKeyFloat",
        "NormalFloat",
        "NormalNC",
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "EndOfBuffer",
        "VertSplit",
        "FloatBorder",
      }
      for _, name in ipairs(hl_group) do
        vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
      end
    end,
  })
end
