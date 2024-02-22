-- improve startup time.
vim.loader.enable()

-- DISABLE REMOTE PLUGINS
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- if neovide
if vim.fn.has "gui_running" == 1 then require "config.neovide" end

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- load config
require "config.options"
require "config.lazy"

-- load the colorscheme here
vim.cmd.colorscheme "gruvbox"

