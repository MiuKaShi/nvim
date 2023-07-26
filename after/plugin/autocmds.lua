local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- go to last loc when opening a buffer
autocmd('BufReadPost', {
  group = augroup('last_loc', {}),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd('LspAttach', {
  group = augroup('UserLspConfig', {}),
  callback = function(args)
    local bufnr = args.buf
    local bufopts = { buffer = bufnr }
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.keymap.set('n', 'J', '<cmd>Lspsaga peek_definition<CR>', bufopts) -- 预览定义
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', bufopts) -- 显示文档定义
    vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>', bufopts) -- 重命名变量
    vim.keymap.set('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<CR>', bufopts) -- 诊断问题
    vim.keymap.set('n', 'gh', '<cmd>Lspsaga finder ref<CR>', bufopts) -- 查找变量名
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', bufopts)
    vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', bufopts) -- 滚动hover 上
    vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', bufopts) -- 滚动hover 下
  end,
})

-- resize splits if window got resized
autocmd({ 'VimResized' }, {
  group = augroup('resize_splits', {}),
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
})

-- Highlight on yank
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200, on_visual = true }
  end,
  pattern = '*',
})

-- Fixing cursor
autocmd('VimLeave', {
  pattern = '*',
  callback = function()
    vim.opt.guicursor = vim.opt.guicursor + { 'a:block-blink100' } -- Block cursor
  end,
})

-- Equalize splites 均分
autocmd('VimResized', {
  callback = function()
    vim.cmd 'wincmd ='
  end,
  desc = 'Equalize Splits',
})

-- For suckless
autocmd({ 'BufWritePost' }, {
  pattern = '.Xresources',
  callback = function()
    vim.cmd '!xrdb %'
    vim.cmd '!pidof st | xargs kill -s USR1'
  end,
  desc = 'Reload st terminal',
})

-- close some filetypes with <q>
autocmd('FileType', {
  group = augroup('close_with_q', {}),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'query', -- :InspectTree
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'vim',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Don't auto commenting new lines
autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o',
})
