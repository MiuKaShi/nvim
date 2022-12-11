-- TURN OFF SOME BUILTIN PLUGINS
vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1

-- DISABLE REMOTE PLUGINS
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

--加速启动
require 'user.impatient'

--基本设置
require 'options'
require 'keymaps'
require 'functions'
require 'plugins'

--插件设置
require 'user.colorscheme'
require 'user.cmp'
require 'user.lsp'
require 'user.lspsaga'
require 'user.neoformat'
require 'user.telescope'
require 'user.treesitter'
require 'user.autopairs'
require 'user.bibtexcite'
require 'user.surround'
-- require 'user.aerial'
require 'user.leap'
require 'user.colorizer'
require 'user.rainbow'
require 'user.comment'
require 'user.lualine'
require 'user.easyalign'
require 'user.fm'
require 'user.mkdp'
require 'user.julia'
require 'user.cinnamon'
require 'user.indentline'
require 'user.whichkey'
require 'user.autocmds'
require 'user.obsidian'
