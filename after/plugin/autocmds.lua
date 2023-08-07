local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc", {}),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("resize_splits", {}),
  callback = function() vim.cmd "tabdo wincmd =" end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 200, on_visual = true } end,
  pattern = "*",
})

-- Fixing cursor
autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    vim.opt.guicursor = vim.opt.guicursor + { "a:block-blink100" } -- Block cursor
  end,
})

-- Equalize splites 均分
autocmd("VimResized", {
  callback = function() vim.cmd "wincmd =" end,
  desc = "Equalize Splits",
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
local smart_hl = vim.api.nvim_create_augroup("smart_hl", { clear = true })
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
autocmd("CursorMoved", {
  group = smart_hl,
  callback = function() start_hl() end,
  desc = "Auto hlsearch",
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
        "TelescopeBorder",
        "TelescopeNormal",
        "TelescopePromptNormal",
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
