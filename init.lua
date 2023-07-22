local option = vim.opt
-- DISABLE REMOTE PLUGINS
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- DISABLE SOME BUILTIN PLUGINS
vim.g.loaded_gzip = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor = 1
vim.g.loaded_zipPlugin = 1

--加速启动
local impatient_ok, impatient = pcall(require, 'impatient')
if impatient_ok then
    impatient.enable_profile()
end

--基本设置
require 'options'
require 'keymaps'
require 'functions'
require 'plugins'
require 'autocmds'
-- neovide setting
if vim.g.neovide then
    require 'neovide'
end

--theme and lsp设置
require 'user.colorscheme'
require 'user.lsp'
