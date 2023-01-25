local opt = vim.opt

-- misc
opt.clipboard = 'unnamedplus'
opt.encoding = 'UTF-8'
opt.shell = 'zsh'

-- UI
opt.title = true
opt.relativenumber = true -- Show relative line numbers
opt.number = true
opt.colorcolumn = '120'
opt.cmdheight = 0
opt.fillchars = { eob = ' ', diff = ' ' }
opt.laststatus = 0
opt.pumheight = 10
opt.scrolloff = 8 -- Always show at least one line above/below the cursor.
opt.termguicolors = true
opt.shortmess:append 'c'
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
-- opt.cursorline = true
-- opt.signcolumn = "yes"
-- opt.cursorline              = true -- 高亮当前行

-- opt
opt.go = 'a'
opt.mouse = 'a'
opt.backspace = 'indent,eol,start' -- 使 backspace 按您预期的方式工作
opt.showmatch = true
opt.visualbell = true

-- Spell
opt.spellsuggest = 'best,9'

-- Completion
opt.completeopt = 'menu,menuone,noselect'

-- search
opt.smartcase = true
opt.ignorecase = true
-- opt.hlsearch = true -- 保持匹配项目高亮
-- opt.incsearch = true -- 搜索时高亮
-- opt.copyindent = true

-- State
opt.swapfile = false
vim.cmd [[
set undofile
set undodir=~/.cache/nvim/undo
set viminfo=!,'10000,<50,s10,h
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
]]

-- Indent
-- opt.expandtab = false -- Use spaces instead of tabs
-- opt.smartindent = true -- Enable smart-indent
opt.shiftwidth = 4 -- Number of auto-indent spaces
opt.softtabstop = 4 -- Number of spaces per <Tab> (use value of sw)
opt.tabstop = 4 -- Ensure files with tabs look the same

-- Time
opt.timeoutlen = 500
opt.updatetime = 200 -- default updatetime 4000ms is not good for async update (vim/signify)

-- Wrap
opt.breakindent = true
opt.linebreak = true
opt.showbreak = '> '
opt.whichwrap:append '[,]'

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
