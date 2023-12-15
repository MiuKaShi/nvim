local options = {
  opt = {
    -- misc
    clipboard = "unnamedplus", -- 使用系统剪切板
    encoding = "utf-8",
    fileencoding = "utf-8",
    termencoding = "utf-8",
    shell = "zsh",

    -- UI
    title = true, -- show title
    showmode = false, -- show mode
    relativenumber = true, -- Show relative line numbers
    number = true,
    -- colorcolumn = '120',
    cmdheight = 0,
    laststatus = 0, -- hide status
    pumheight = 10, -- Height of the pop up menu
    scrolloff = 5, -- Number of lines to keep above and below the cursor
    sidescrolloff = 5, -- Number of columns to keep at the sides of the cursor
    termguicolors = true, -- Enable 24-bit RGB color
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg --hidden --vimgrep --smart-case --", -- Replace Vimgrep with Ripgrep
    syntax = "on", -- 打开语法高亮
    signcolumn = "yes:1", -- 显示标记列,设置宽度为1
		ttyfast = true, -- 优化tty速度
    cursorline = true, -- 高亮光标
    cursorlineopt = "number", -- 高亮行号
    numberwidth = 3, -- 行号宽度
    guicursor = vim.opt.guicursor + { "a:blinkon100" }, -- 光标闪烁速度

    -- Format
    formatoptions = "jcroqlnt", -- tcqj

    -- opt
    go = "a",
    mouse = "a", --启用鼠标支持
    backspace = "indent,eol,start", -- 指定 backspace 可以删除的内容
    showmatch = true, --括号高亮
    visualbell = true, --视觉提示
    autochdir = true, -- 总是在当前目录下执行命令

    -- Spell
    spellsuggest = "best,9", --优先使用最好的9个建议

    -- Completion
    completeopt = "menu,menuone,noselect", --多个或单个补全启用菜单显示,不自动选择第一个

    -- Indent
    -- expandtab = false,  -- Use spaces instead of tabs
    -- smartindent = true,  -- Enable smart-indent
    shiftwidth = 2, -- Number of auto-indent spaces
    softtabstop = 2, -- Number of spaces per <Tab> (use value of sw)
    tabstop = 2, -- Ensure files with tabs look the same
    preserveindent = true, -- Preserve indent structure as much as possible

    -- Time
    timeoutlen = 300, -- 键位响应视觉
    updatetime = 50, -- default updatetime 4000ms is not good for async update (vim/signify)
    timeout = true,
    ttimeout = true,
    ttimeoutlen = 10,

    -- Wrap
    -- wrap = false,  -- Disable wrapping
    -- enable wrap
    breakindent = true,
    linebreak = true,
    showbreak = "↪ ", --断行提示符

    -- fold
    foldenable = true,
    foldmethod = "manual", -- 折叠的方式
    foldlevel = 99, -- 折叠的级别（100）
    foldlevelstart = 99,
    -- o.foldcolumn = "1"
    fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" },

    -- search
    smartcase = true,
    ignorecase = true, --忽略大写
    -- hlsearch = true,  -- 保持匹配项目高亮
    -- incsearch = true,  -- 搜索时高亮
    -- copyindent = true,

    -- HISTORY
    swapfile = false,
    backup = false,
    undofile = true,
    undolevels = 1000,
  },

  g = {
    mapleader = " ",
    maplocalleader = " ",
    highlighturl_enabled = true, -- highlight URLs
    transparent_nvim = true, -- Set true to transparent
  },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end

vim.opt.shortmess:append { W = true, I = true, c = true, C = true }
vim.opt.diffopt:append { linematch = 60 } -- diff模式时,最大行数60
vim.opt.whichwrap:append "[,]" -- 添加[和]用作行移动

vim.cmd [[filetype plugin indent on]]

-- undofile
vim.cmd [[
set undodir=~/.cache/nvim/undo
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
]]
