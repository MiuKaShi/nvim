local api = vim.api
local Util = require 'lazy.core.util'

local M = {}

M.root_patterns = { '.git', 'lua' }

---@param plugin string
function M.has(plugin)
  return require('lazy.core.config').plugins[plugin] ~= nil
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = api.nvim_buf_get_name(0)
  path = path ~= '' and vim.uv.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients { bufnr = 0 }) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.uv.fs_realpath(p)
        if r and path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
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
  return function()
    require('telescope.builtin')[builtin](opts or {})
  end
end

---wrap of telescope extension functions
---@param extn string
---@param opts table?
---@return function
function M.tele_extn(extn, opts)
  return function()
    require('telescope').extensions[extn][extn](opts or {})
  end
end

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend('force', { cwd = M.get_root() }, opts or {})
    if builtin == 'files' then
      if vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. '/.git') then
        opts.show_untracked = true
        builtin = 'git_files'
      else
        builtin = 'find_files'
      end
    end
    require('telescope.builtin')[builtin](opts)
  end
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
    return Util.info('Set ' .. option .. ' to ' .. api.nvim_get_option_value(option, {}), { title = 'Option' })
  end
  vim.opt_local[option] = not api.nvim_get_option_value(option, {})
  if not silent then
    if api.nvim_get_option_value(option, {}) then
      Util.info('Enabled ' .. option, { title = 'Option' })
    else
      Util.warn('Disabled ' .. option, { title = 'Option' })
    end
  end
end

vim.diagnostic.disable()
local disabled = true
function M.toggle_diagnostics()
  disabled = not disabled
  if disabled then
    vim.diagnostic.disable()
    vim.opt.showmode = false
    vim.opt.ruler = false
    vim.opt.laststatus = 0
    vim.opt.showcmd = false
    Util.info('Disabled diagnostics', { title = 'Diagnostics' })
  else
    vim.diagnostic.enable()
    vim.opt.showmode = true
    vim.opt.ruler = true
    vim.opt.laststatus = 2
    vim.opt.showcmd = true
    Util.warn('Enabled diagnostics', { title = 'Diagnostics' })
  end
end

return M
