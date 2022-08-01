require 'impatient' -- 加速度模块
require 'lsp'

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

-- 主题设置
vim.g.gruvbox_contrast_dark = "hard"
vim.cmd 'colorscheme gruvbox'
vim.cmd [[
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi LineNR guibg=NONE ctermbg=NONE
hi CursorLineNR guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi MsgArea ctermbg=NONE guibg=NONE
hi Pmenu guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
]]

-- PLUGINS And LSP LIST
vim.defer_fn(function()
	require 'plugins'
end, 800)


-- LSP toggle
vim.cmd [[
let s:hidden_all = 0
lua vim.diagnostic.disable()
function! ToggleHiddenAll()
    if s:hidden_all  == 1
        let s:hidden_all = 1
        lua vim.diagnostic.disable()
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set signcolumn =no
    else
        let s:hidden_all = 0
        lua vim.diagnostic.enable()
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set signcolumn =yes
    endif
endfunction]]
