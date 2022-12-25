vim.cmd 'syntax on' -- 打开语法高亮
vim.cmd 'filetype plugin indent on'
local o = vim.opt

-- global
vim.o.clipboard = 'unnamedplus'
vim.o.shell = 'zsh'
vim.o.cmdheight = 0
vim.o.laststatus = 0
vim.o.pumheight = 10
vim.o.scrolloff = 8 -- Always show at least one line above/below the cursor.
vim.o.showbreak = '> '
vim.o.title = true
vim.o.termguicolors = true
vim.o.updatetime = 200 -- default updatetime 4000ms is not good for async update (vim/signify)

-- local to window
vim.wo.relativenumber = true -- Show relative line numbers
vim.wo.number = true
vim.wo.colorcolumn = '120'
vim.wo.linebreak = true

-- search
vim.o.smartcase = true
vim.o.ignorecase = true
-- vim.o.hlsearch = true -- 保持匹配项目高亮
-- vim.o.incsearch = true -- 搜索时高亮
-- vim.o.copyindent = true

-- indention & tab
local indent = 4
vim.o.tabstop = indent -- Ensure files with tabs look the same
vim.o.shiftwidth = indent -- Number of auto-indent spaces
vim.o.softtabstop = indent -- Number of spaces per <Tab> (use value of sw)

-- local to buffer
vim.bo.smartindent = true -- Enable smart-indent
vim.bo.undofile = true
vim.bo.undolevels = 1000
vim.bo.swapfile = false

-- Completion
o.completeopt = 'menu,menuone,noselect'

-- opt
o.shortmess:append('c')
o.whichwrap:append('[,]')
o.backspace = 'indent,eol,start' -- 使 backspace 按您预期的方式工作
o.timeoutlen = 500
o.go = 'a'
o.mouse = 'a'
o.showmatch = true
o.visualbell = true
o.spellsuggest='best,9'
--o.regexpengine = 1
-- o.cursorline              = true -- 高亮当前行

-- backup
o.backup = true
vim.cmd [[
set undodir=$HOME/.cache/nvim/undo
set backupdir=$HOME/.cache/nvim/backup
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif
]]

-- Others
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
