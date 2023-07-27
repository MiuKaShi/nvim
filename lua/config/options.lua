vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- misc
opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.termencoding = "utf-8"
opt.shell = "zsh"

-- UI
opt.title = true -- show title
opt.showmode = false -- show mode
opt.relativenumber = true -- Show relative line numbers
opt.number = true
-- opt.colorcolumn = '120'
opt.cmdheight = 0
opt.fillchars = { eob = " ", diff = " " }
opt.laststatus = 0 -- hide status
opt.pumheight = 10 -- Height of the pop up menu
opt.scrolloff = 4 -- Number of lines to keep above and below the cursor
opt.sidescrolloff = 4 -- Number of columns to keep at the sides of the cursor
opt.termguicolors = true -- Enable 24-bit RGB color
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --hidden --vimgrep --smart-case --" -- Replace Vimgrep with Ripgrep   hlsearch = true,
opt.syntax = "on" -- 打开语法高亮
opt.signcolumn = "yes:1" -- 显示标记列,设置宽度为1
opt.cursorline = true -- 高亮光标
opt.cursorlineopt = "number" -- 高亮行号
opt.numberwidth = 3 -- 行号宽度
opt.guicursor = vim.opt.guicursor + { "a:blinkon100" } -- 光标闪烁速度

-- Diff
opt.diffopt:append { linematch = 60 } -- diff模式时,最大行数60

-- Format
opt.formatoptions = "jcroqlnt" -- tcqj

-- opt
opt.go = "a"
opt.mouse = "a" --启用鼠标支持
opt.backspace = "indent,eol,start" -- 指定 backspace 可以删除的内容
opt.showmatch = true --括号高亮
opt.visualbell = true --视觉提示

-- Spell
opt.spellsuggest = "best,9" --优先使用最好的9个建议

-- Completion
opt.completeopt = "menu,menuone,noselect" --多个或单个补全启用菜单显示,不自动选择第一个

-- Indent
-- opt.expandtab = false -- Use spaces instead of tabs
-- opt.smartindent = true -- Enable smart-indent
opt.shiftwidth = 2 -- Number of auto-indent spaces
opt.softtabstop = 2 -- Number of spaces per <Tab> (use value of sw)
opt.tabstop = 2 -- Ensure files with tabs look the same
opt.preserveindent = true -- Preserve indent structure as much as possible

-- Time
opt.timeoutlen = 300 -- 键位响应视觉
opt.updatetime = 50 -- default updatetime 4000ms is not good for async update (vim/signify)

-- Wrap
-- opt.wrap = false -- Disable wrapping
-- enable wrap
opt.breakindent = true
opt.linebreak = true
opt.showbreak = "> " --断行提示符
opt.whichwrap:append "[,]" -- 添加[和]用作行移动

-- search
opt.smartcase = true
opt.ignorecase = true --忽略大写
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
