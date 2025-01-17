-- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup {
  spec = {
    { import = "plugins" },
    { import = "themes" },
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
