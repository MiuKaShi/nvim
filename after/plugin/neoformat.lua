-- 1.自动对齐
vim.g.neoformat_basic_format_align = 1
-- 2.自动删除行尾空格
vim.g.neoformat_basic_format_trim = 2
-- 3.将制表符替换为空格
vim.g.neoformat_basic_format_retab = 1
-- 只提示错误消息
vim.g.neoformat_only_msg_on_error = 1

vim.g.neoformat_enabled_markdown = { 'prettier' }
vim.g.neoformat_enabled_html = { 'prettier' }
vim.g.neoformat_enabled_json = { 'prettier' }
vim.g.neoformat_enabled_yaml = { 'prettier' }
-- vim.g.neoformat_enabled_yaml = {'yamlfmt'}
-- sh
vim.g.neoformat_enabled_sh = { 'shfmt' }
vim.g.shfmt_opt = '-i 4 -ci -bn' -- google style sh
-- python
vim.g.neoformat_enabled_python = { 'black' }

-- C family
vim.g.neoformat_cpp_astyle = {
    exe = 'astyle',
    args = {
        '--mode=c',
        '--indent=spaces=4',
        '--convert-tabs',
        '--pad-oper',
        '--indent-col1-comments',
        '--unpad-paren',
        '--max-code-length=120',
        '--add-one-line-brackets',
        '--style=linux',
        '--indent-classes',
        '--keep-one-line-statements',
        '--add-brackets',
        '--pad-header',
        '--break-blocks',
        '--indent=spaces=4',
        '--convert-tabs',
        '--break-after-logical',
        '--min-conditional-indent=2',
        '--max-instatement-indent=40',
        '--keep-one-line-blocks',
    },
    replace = 0,
    stdin = 1,
    valid_exit_codes = { 0, 23 },
    no_append = 0,
}

vim.g.neoformat_enabled_cpp = { 'astyle' }
vim.g.neoformat_enabled_c = { 'astyle' }

vim.cmd [[
augroup fmt
autocmd!
autocmd BufWritePre *.sh Neoformat
autocmd BufWritePre *.py Neoformat
" autocmd BufWritePre *.lua lua require("stylua-nvim").format_file()
" autocmd BufWritePre *.md Neoformat
autocmd BufWritePre *.json, yaml,*.yml Neoformat
autocmd BufWritePre *.c,*.h,*.cc,*.hh,*.cpp,*.hpp Neoformat
augroup END
]]
