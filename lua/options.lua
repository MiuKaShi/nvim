local o = vim.opt

-- global
vim.o.clipboard = 'unnamedplus'
vim.o.cmdheight = 0
vim.o.shell = 'zsh'
vim.o.fillchars = 'eob: ,diff: '
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep'
vim.o.laststatus = 0
vim.o.pumheight = 10
vim.o.scrolloff = 8 -- Always show at least one line above/below the cursor.
vim.o.showbreak = '> '
vim.o.title = true
vim.o.termguicolors = true
vim.o.updatetime = 200 -- default updatetime 4000ms is not good for async update (vim/signify)

-- opt
o.encoding = 'UTF-8'
o.shortmess:append 'c'
o.whichwrap:append '[,]'
o.backspace = 'indent,eol,start' -- 使 backspace 按您预期的方式工作
o.timeoutlen = 500
o.go = 'a'
o.mouse = 'a'
o.showmatch = true
o.visualbell = true
o.spellsuggest = 'best,9'
--o.regexpengine = 1
-- o.cursorline              = true -- 高亮当前行

-- Completion
o.completeopt = 'menu,menuone,noselect'

-- search
vim.o.smartcase = true
vim.o.ignorecase = true
-- vim.o.hlsearch = true -- 保持匹配项目高亮
-- vim.o.incsearch = true -- 搜索时高亮
-- vim.o.copyindent = true

-- local to buffer
vim.bo.swapfile = false
-- undofile
vim.cmd [[
set undofile
set undodir=~/.cache/nvim/undo
set viminfo=!,'10000,<50,s10,h
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
]]

-- Tabs
vim.bo.expandtab = true -- Use spaces instead of tabs
vim.bo.smartindent = true -- Enable smart-indent
vim.bo.shiftwidth = 2 -- Number of auto-indent spaces
vim.bo.softtabstop = 2 -- Number of spaces per <Tab> (use value of sw)
vim.bo.tabstop = 2 -- Ensure files with tabs look the same

-- local to window
vim.wo.breakindent = true
vim.wo.colorcolumn = '120'
vim.wo.number = true
vim.wo.linebreak = true
vim.wo.relativenumber = true -- Show relative line numbers
--vim.wo.cursorline = true
--vim.wo.signcolumn = "yes"

-- Others
-- 光标回到上次位置
vim.cmd 'syntax on' -- 打开语法高亮
vim.cmd [[ 
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 
]]
vim.g.GfList_map_n_gf = 'gf' -- gf 自定义
vim.g.GfList_map_v_gf = 'gf'
vim.cmd [[
let g:gtfo#terminals = { 'unix': 'st -e nvim' }
]]
vim.cmd [[
let g:fzf_wordnet_preview_arg = ''
]]

-- 文件格式设置
vim.cmd [[
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.tp set filetype=type
autocmd BufRead,BufNewFile *.m set filetype=matlab
autocmd BufRead,BufNewFile *.md set filetype=markdown.pandoc
autocmd BufRead,BufNewFile lfrc set filetype=lf
autocmd BufRead,BufNewFile *.sage set filetype=sage
autocmd BufRead,BufNewFile sxhkdrc,*.sxhkdrc set filetype=sxhkdrc
autocmd BufRead,BufNewFile *tridactylrc set filetype=tridactyl
autocmd BufRead,BufNewFile *.pyx set filetype=cython
autocmd BufRead,BufNewFile *.pxd set filetype=cython
autocmd BufRead,BufNewFile *.pxi set filetype=cython
]]
