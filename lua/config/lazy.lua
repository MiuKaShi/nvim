-- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local args = { "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath }
  local out = vim.system(args):wait()
  if out.code ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n" .. out.stderr, "ErrorMsg" } }, true, {})
    vim.fn.getchar() -- wait for keypress
    os.exit(1)
  end
end
vim.opt.runtimepath:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup {
  spec = {
    { import = "plugins" },
    { import = "colorschemes" },
  },
  defaults = { lazy = true, version = false }, -- always use the latest git commit
  ui = {
    wrap = true,
    border = "single",
    pills = false,
    size = { width = 0.85, height = 0.85 },
    backdrop = 70, -- 0-100 opacity
  },
  checker = {
    enabled = true,
    notify = false,
    frequency = 60 * 60 * 24, -- 1 day
  },
  change_detection = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tar",
        "tarPlugin",
        "zip",
        "zipPlugin",
        "loaded_2html_plugin", -- disable 2html
        "loaded_getscript", -- disable getscript
        "loaded_getscriptPlugin", -- disable getscript
        "loaded_vimball", -- disable vimball
        "loaded_vimballPlugin", -- disable vimball
        "matchit",
        "matchparen",
        "logiPat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "rrhelper",
        "rplugin",
        "shada",
        "spellfile",
        "tohtml",
        "tutor",
      },
    },
  },
}

local function checkForPluginUpdates()
  if not require("lazy.status").has_updates() then return end
  local threshold = 20
  local numberOfUpdates = tonumber(require("lazy.status").updates():match "%d+")
  if numberOfUpdates < threshold then return end
  vim.notify(("󱧕 %s plugin updates"):format(numberOfUpdates), vim.log.levels.INFO, { title = "Lazy" })
end

vim.defer_fn(checkForPluginUpdates, 10000)
