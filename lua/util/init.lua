local api = vim.api
local Util = require "lazy.core.util"

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
      print("remove source: " .. src)
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
  -- local fgdark = "#2E3440"
  -- vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = fgdark, bg = "#D4BB6C" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#7E8294" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#7E8294" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#D4A959" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#D4A959" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#6C8ED4" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#6C8ED4" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })
  --
  -- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = fgdark, bg = "#58B5A8" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
  -- vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    if api.nvim_get_option_value(option, {}) == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return Util.info("Set " .. option .. " to " .. api.nvim_get_option_value(option, {}), { title = "Option" })
  end
  vim.opt_local[option] = not api.nvim_get_option_value(option, {})
  if not silent then
    if api.nvim_get_option_value(option, {}) then
      Util.info("Enabled " .. option, { title = "Option" })
    else
      Util.warn("Disabled " .. option, { title = "Option" })
    end
  end
end

vim.diagnostic.disable(1)
function M.toggle_diagnostics()
  if vim.diagnostic.is_disabled(0) then
    vim.diagnostic.enable(0)
    vim.opt.showmode = true
    vim.opt.ruler = true
    vim.opt.laststatus = 2
    vim.opt.showcmd = true
  else
    vim.diagnostic.disable(0)
    vim.opt.showmode = false
    vim.opt.ruler = false
    vim.opt.laststatus = 0
    vim.opt.showcmd = false
  end
end

return M
