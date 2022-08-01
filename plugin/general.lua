-- vim.cmd('silent! colorscheme neon')
vim.cmd 'syntax on' -- 打开语法高亮
vim.cmd 'filetype plugin indent on' -- 根据检测到文件类型加载插件

-- minimal working config
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.number         = true
vim.opt.textwidth      = 120 -- Line wrap (number of cols)
vim.opt.linebreak      = true
vim.opt.showbreak      = '> '
vim.opt.title          = true

-- search
vim.opt.hlsearch   = true -- 保持匹配项目高亮
vim.opt.smartcase  = true
vim.opt.ignorecase = true
vim.opt.incsearch  = true -- 搜索时高亮
vim.opt.copyindent = true

-- indention & tab
vim.opt.tabstop     = 4 -- Ensure files with tabs look the same
vim.opt.shiftwidth  = 4 -- Number of auto-indent spaces
vim.opt.expandtab   = true -- Use spaces instead of tabs
vim.opt.softtabstop = -1 -- Number of spaces per <Tab> (use value of sw)
vim.opt.smarttab    = true -- Enable smart-tabs (<Tab> will always use sw)

vim.opt.autoindent  = false -- Disabel Auto-indent new lines
vim.opt.smartindent = true -- Enable smart-indent
vim.opt.pumheight   = 10

-- Hide bottom status
vim.opt.laststatus = 0
vim.opt.ruler      = false
vim.opt.showmode   = false
vim.opt.showcmd    = false

-- backups
vim.opt.undofile   = true
vim.opt.backup     = true
vim.opt.swapfile   = false
vim.opt.undolevels = 1000
vim.opt.updatetime = 100 -- default updatetime 4000ms is not good for async update (vim/signify)
vim.opt.backspace  = 'indent,eol,start' -- 使 backspace 按您预期的方式工作
vim.opt.clipboard  = 'unnamedplus'
vim.opt.shell      = 'zsh'
--
vim.opt.timeoutlen              = 500
vim.opt.go                      = 'a'
vim.opt.mouse                   = 'a'
vim.opt.encoding                = 'UTF-8'
vim.opt.fileencoding            = 'UTF-8'
vim.opt.fileencodings           = 'UTF-8'
vim.opt.termguicolors           = true
vim.opt.lazyredraw              = true -- Speeds up scrolling
vim.opt.redrawtime              = 10000
vim.opt.regexpengine            = 1
vim.opt.scrolloff               = 8 -- Always show at least one line above/below the cursor.
vim.opt.showmatch               = true
vim.opt.visualbell              = true
-- opt.cursorline              = true -- 高亮当前行
vim.opt.whichwrap               = 'b,s,<,>,[,]'
vim.g.user_emmet_settings       = {
    javascript = { extends = 'jsx' },
    typescript = { extends = 'tsx' },
}
-- Set completeopt to have a better completion experience
vim.opt.completeopt             = 'menu,menuone,noselect'
vim.g.rainbow_active            = 1
vim.g.neon_style                = 'doom'
vim.g.EasyMotion_do_mapping     = 0
vim.g.EasyMotion_smartcase      = 1
vim.g.swoopAutoInsertMode       = 1
vim.g.user_emmet_install_global = 0
-- gf 自定义
vim.g.GfList_map_n_gf           = 'gf'
vim.g.GfList_map_v_gf           = 'gf'

vim.cmd [[
let g:gtfo#terminals = { 'unix': 'st -e nvim' }
]]

vim.cmd [[
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
]]

vim.cmd [[
if has("nvim")
    set undodir=$HOME/.cache/nvim/undo
    set backupdir=$HOME/.cache/nvim/backup
else
    set undodir=$HOME/.cache/vim/undo
    set backupdir=$HOME/.cache/vim/backup
endif
]]

vim.cmd [[
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif
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
autocmd BufRead,BufNewFile sxhkdrc,*.sxhkdrc set filetype=sxhkdrc
]]
