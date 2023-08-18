-- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup {
  spec = {
    { import = "plugins" },
    { import = "themes" },
  },
  defaults = { lazy = true, version = false }, -- always use the latest git commit
  diff = {
    cmd = "diffview.nvim",
  },
  ui = { border = "single" },
  change_detection = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tar",
        "tarPlugin",
        "zip",
        "zipPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
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
