local opt = vim.opt

-- misc
opt.clipboard = 'unnamedplus'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.termencoding = 'utf-8'
opt.shell = 'zsh'

-- UI
opt.title = true
opt.relativenumber = true -- Show relative line numbers
opt.number = true
-- opt.colorcolumn = '120'
opt.cmdheight = 0
opt.fillchars = { eob = ' ', diff = ' ' }
opt.laststatus = 0
opt.pumheight = 10 -- Height of the pop up menu
opt.scrolloff = 4 -- Number of lines to keep above and below the cursor
opt.sidescrolloff = 4 -- Number of columns to keep at the sides of the cursor
opt.termguicolors = true -- Enable 24-bit RGB color
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --hidden --vimgrep --smart-case --' -- Replace Vimgrep with Ripgrep   hlsearch = true,
opt.syntax = 'on' -- 打开语法高亮
opt.signcolumn = 'yes:1'
opt.cursorline = true
opt.cursorlineopt = 'number'
opt.numberwidth = 3
opt.guicursor = vim.opt.guicursor + { 'a:blinkon100' } -- Fix for blinking cursor

-- Diff
opt.diffopt:append { linematch = 60 }

-- Format
opt.formatoptions = 'tcroqnlj'

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

-- Indent
-- opt.expandtab = false -- Use spaces instead of tabs
-- opt.smartindent = true -- Enable smart-indent
opt.shiftwidth = 2 -- Number of auto-indent spaces
opt.softtabstop = 2 -- Number of spaces per <Tab> (use value of sw)
opt.tabstop = 2 -- Ensure files with tabs look the same
opt.preserveindent = true -- Preserve indent structure as much as possible

-- Time
opt.timeoutlen = 300
opt.updatetime = 50 -- default updatetime 4000ms is not good for async update (vim/signify)

-- Wrap
-- wrap = false -- Disable wrapping of lines longer than the width of window
-- enable wrap
opt.breakindent = true
opt.linebreak = true
opt.showbreak = '> '
opt.whichwrap:append '[,]'

-- search
opt.smartcase = true
opt.ignorecase = true
-- opt.hlsearch = true -- 保持匹配项目高亮
-- opt.incsearch = true -- 搜索时高亮
-- opt.copyindent = true

-- HISTORY
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undolevels = 1000

-- undofile
vim.cmd [[
set undodir=~/.cache/nvim/undo
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
]]

-- Others
-- 光标回到上次位置
vim.cmd [[ 
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 
]]
vim.g.GfList_map_n_gf = 'gf' -- gf 自定义
vim.g.GfList_map_v_gf = 'gf'
vim.cmd [[
let g:fzf_wordnet_preview_arg = ''
]]

-- neovide setting
if vim.g.neovide then
    require 'user.neovide'
end
