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

-- for rime_status
function M.rime_status()
  if vim.g.rime_enabled then
    return "CN"
  else
    return "EN"
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
  local isLetter = charUnderCursor:lower() ~= charUnderCursor:upper() -- so it works with diacritics
  if isLetter then
    normal "~h"
    return
  end
  for left, right in pairs(toggleSigns) do
    if charUnderCursor == left then normal("r" .. right) end
    if charUnderCursor == right then normal("r" .. left) end
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

-- cmp toggle source
function M.cmp_toggle_source(src)
  local cmp = require "cmp"
  local sources = cmp.get_config().sources
  -- remove source
  for i = #sources, 1, -1 do
    if sources[i].name == src then
      table.remove(sources, i)
      cmp.setup.buffer { sources = sources }
      vim.notify("remove source:." .. src, vim.log.levels.WARN)
      return
    end
  end
  --add source
  local priority = ({
    ["nvim_lsp"] = function() return 1000 end,
    ["nvim_lsp_signature_help"] = function() return 900 end,
    ["copilot"] = function() return 850 end,
    ["buffer"] = function() return 800 end,
    ["luasnip"] = function() return 700 end,
    ["path"] = function() return 600 end,
    ["look"] = function() return 200 end,
  })[src] or function() return 100 end -- 默认优先级
  table.insert(sources, { name = src, priority() })
  cmp.setup.buffer { sources = sources }
  print("add source: " .. src)
end

-- CMP highlight
function M.setcmphl()
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
  vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#808080", bg = "NONE", italic = true })
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644", bg = "NONE" })

  -- vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}

-- toggle inlay hints
function M.inlay_hints()
  local inlay_hint_status = vim.lsp.inlay_hint.is_enabled(0)
  vim.lsp.inlay_hint.enable(0, not inlay_hint_status)
end


-- toggle spellcheck
function M.toggle_spellcheck()
  if vim.opt.spell:get() then
    vim.opt.spell = false
  else
    vim.opt.spell = true
    vim.cmd [[
		syn match myExCapitalWords +\<[A-Z]\w*\>+ contains=@NoSpell
		syn match NoSpellAcronym '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
		syn match LowerCaseAtStart "^\s*\l" contains=@NoSpell
		]]
  end
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
