-- SOME GLOBAL FUNCTIONS
P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return require('plenary.reload').reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end

-- LSP toggle
vim.cmd [[
let s:hidden_all = 0
lua vim.diagnostic.disable()
function! ToggleHiddenAll()
    if s:hidden_all  == 0
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
