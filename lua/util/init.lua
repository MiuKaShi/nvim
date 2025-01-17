local api = vim.api

local M = {}

M.root_patterns = { ".git", "lua" }

---@param plugin string
function M.has(plugin) return require("lazy.core.config").plugins[plugin] ~= nil end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = api.nvim_buf_get_name(0)
  path = path ~= "" and vim.uv.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients { bufnr = 0 }) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws) return vim.uri_to_fname(ws.uri) end, workspace)
        or client.config.root_dir and { client.config.root_dir }
        or {}
      for _, p in ipairs(paths) do
        local r = vim.uv.fs_realpath(p)
        if r and path:find(r, 1, true) then roots[#roots + 1] = r end
      end
    end
  end
  table.sort(roots, function(a, b) return #a > #b end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.uv.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.uv.cwd()
  end
  ---@cast root string
  return root
end

---wrap of telescope builtin functions
---@param builtin string
---@param opts table?
---@return function
function M.tele_builtin(builtin, opts)
  return function() require("telescope.builtin")[builtin](opts or {}) end
end

---wrap of telescope extension functions
---@param extn string
---@param opts table?
---@return function
function M.tele_extn(extn, opts)
  return function() require("telescope").extensions[extn][extn](opts or {}) end
end

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
    if builtin == "files" then
      if vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

-- better toggleCase
local function normal(cmd) vim.cmd.normal { cmd, bang = true } end
function M.toggleCase()
  local toggleSigns = {
    ["="] = "!",
    ["|"] = "&",
    [","] = ";",
    ["'"] = '"',
    ["^"] = "$",
    ["/"] = "*",
    ["+"] = "-",
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
    ["<"] = ">",
  }
  local col = vim.fn.col "." -- fn.col correctly considers tab-indentation
  local charUnderCursor = vim.api.nvim_get_current_line():sub(col, col)
  local changeTo
  for left, right in pairs(toggleSigns) do
    if charUnderCursor == left then changeTo = right end
    if charUnderCursor == right then changeTo = left end
  end
  if changeTo then
    normal("r" .. changeTo)
  else
    normal "v~" -- (`v~` instead of `~h` so dot-repetition doesn't move cursor)
  end
end

-- duplicateAsComment
function M.duplicateAsComment()
  local ln, col = unpack(vim.api.nvim_win_get_cursor(0))
  local curLine = vim.api.nvim_get_current_line()
  local indent, content = curLine:match "^(%s*)(.*)"
  local commentedLine = indent .. vim.bo.commentstring:format(content)
  vim.api.nvim_buf_set_lines(0, ln - 1, ln, false, { commentedLine, curLine })
  vim.api.nvim_win_set_cursor(0, { ln + 1, col })
end

-- https://jupytext.readthedocs.io/en/latest/formats-scripts.html#the-percent-format
function M.insertDoublePercentCom()
  if vim.bo.commentstring == "" then return end
  local curLine = vim.api.nvim_get_current_line()
  local doublePercentCom = vim.bo.commentstring:format "%%"
  local ln = vim.api.nvim_win_get_cursor(0)[1]
  if curLine == "" then
    vim.api.nvim_set_current_line(doublePercentCom)
    ln = ln - 1
  else
    vim.api.nvim_buf_set_lines(0, ln, ln, false, { doublePercentCom })
  end
  vim.api.nvim_buf_add_highlight(0, 0, "DiagnosticVirtualTextHint", ln, 0, -1)
end

function M.removeDoublePercentComs()
  if vim.bo.commentstring == "" then return end
  local cursorBefore = vim.api.nvim_win_get_cursor(0)
  local doublePercentCom = vim.bo.commentstring:format "%%"
  vim.cmd("% substitute/" .. doublePercentCom .. "//")
  vim.api.nvim_win_set_cursor(0, cursorBefore)
end

-- word count
function M.getwords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "text" or vim.bo.filetype == "markdown.pandoc" then
    if vim.fn.wordcount().visual_words == nil then return tostring(vim.fn.wordcount().words) end
    return tostring(vim.fn.wordcount().visual_words)
  else
    return ""
  end
end

-- Width of side windows
function M.width()
  local columns = vim.go.columns
  return math.floor(columns * 0.2) > 25 and math.floor(columns * 0.2) or 25
end

-- Width of side windows
function M.togglecli(cli)
  local Terminal = require("toggleterm.terminal").Terminal
  return Terminal:new({ cmd = cli, hidden = true, direction = "float" }):toggle()
end

-- toggle inlay hints
function M.toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
end

-- toggle spellcheck
function M.toggle_spellcheck()
  if vim.wo.spell then
    vim.wo.spell = false
  else
    vim.wo.spell = true
    vim.cmd [[
		syn match myExCapitalWords +\<[A-Z]\w*\>+ contains=@NoSpell
		syn match NoSpellAcronym '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
		syn match LowerCaseAtStart "^\s*\l" contains=@NoSpell
		]]
  end
end

-- rime-ls
function M.rime_status_icon() return vim.g.rime_enabled and "CN" or "EN" end

local function contains_unacceptable_character(content)
  if content == nil then return true end
  local ignored_head_number = false
  for i = 1, #content do
    local b = string.byte(content, i)
    if b >= 48 and b <= 57 or b == 32 or b == 46 then
      -- number dot and space
      if ignored_head_number then return true end
    elseif b <= 127 then
      return true
    else
      ignored_head_number = true
    end
  end
  return false
end

function M.is_rime_item(item)
  if item == nil or item.source_name ~= "LSP" then return false end
  local client = vim.lsp.get_client_by_id(item.client_id)
  return client ~= nil and client.name == "rime_ls"
end

function M.rime_item_acceptable(item)
  return not contains_unacceptable_character(item.label) or item.label:match "%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d"
end

function M.get_n_rime_item_index(n, items)
  if items == nil then items = require("blink.cmp.completion.list").items end
  local result = {}
  if items == nil or #items == 0 then return result end
  for i, item in ipairs(items) do
    if M.is_rime_item(item) and M.rime_item_acceptable(item) then
      result[#result + 1] = i
      if #result == n then break end
    end
  end
  return result
end

-- toggle diagnostic
vim.diagnostic.disable(1)
function M.toggle_diagnostics()
  if vim.diagnostic.is_disabled(0) then
    vim.diagnostic.enable(0)
    vim.opt.showmode = true
    vim.opt.ruler = true
    vim.opt.laststatus = 2
    vim.opt.showcmd = true
    vim.notify("Diagnostic Enable", vim.log.levels.INFO)
  else
    vim.diagnostic.disable(0)
    vim.opt.showmode = false
    vim.opt.ruler = false
    vim.opt.laststatus = 0
    vim.opt.showcmd = false
    vim.notify("Diagnostic Disable", vim.log.levels.WARN)
  end
end

M.textobjectRemaps = {
  c = "}", -- [c]urly brace
  r = "]", -- [r]ectangular bracket
  m = "W", -- [m]assive word
  q = '"', -- [q]uote
  z = "'", -- [z]ingle quote
  e = "`", -- t[e]mplate string / inline cod[e]
}

return M
