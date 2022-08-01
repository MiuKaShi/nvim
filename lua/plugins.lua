local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
local packer_bootstrap = nil

-- Automatically install packer
if not packer_exists then
    if vim.fn.input 'Download Packer? (y for yes) ' ~= 'y' then
        print 'Please install Packer first!'
        return
    end

    local directory = string.format('%s/site/pack/packer/opt/', vim.fn.stdpath 'data')

    vim.fn.mkdir(directory, 'p')

    print ' Downloading packer.nvim...'
    local install_path = directory .. '/packer.nvim'
    packer_bootstrap = vim.fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print(packer_bootstrap)

    vim.cmd [[packadd packer.nvim]]
end

vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
	command = 'source <afile> | PackerCompile',
	pattern = 'plugins.lua',
	group   = 'packer_user_config',
	desc    = 'Compile whenever plugins.lua is updated',
})

-- plugin lists
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    -- theme
    use 'ellisonleao/gruvbox.nvim'
    use 'norcalli/nvim-colorizer.lua' -- editor 内颜色显示

    -- LSP
    use 'neovim/nvim-lspconfig' -- lsp 配置插件
    use 'onsails/lspkind-nvim' -- vscode-like lsp 提示
    use 'tami5/lspsaga.nvim' -- LSP UI

    -- Format
    use 'sbdchd/neoformat'
    use 'junegunn/vim-easy-align'
    use 'ckipp01/stylua-nvim'

    -- Syntax
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground', opt = true }
	use 'nvim-treesitter/nvim-treesitter-context'
    use 'lambdalisue/vim-cython-syntax' 
    -- use {
    --     'vim-pandoc/vim-pandoc-syntax',
    --     config = function()
    --         vim.cmd [[
    --     augroup pandoc_syntax
    --     autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    --     autocmd BufNewFile,BufFilePre,BufRead *.md set syntax=markdown.pandoc
    --     augroup END
    --   ]]
    --     end,
    -- }
    use 'luochen1990/rainbow' -- 嵌套括号高亮
    use 'RRethy/vim-illuminate' -- 高亮选中单词
    use 'folke/lua-dev.nvim' -- lua 语法提示 for lsp
    use 'tridactyl/vim-tridactyl' -- tridactyl 高亮

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'lukas-reineke/cmp-rg',
            -- 'mstanciu552/cmp-octave', -- octave 自动补偿
            'mstanciu552/cmp-matlab', -- matlab 自动补偿
        },
    }
    use 'L3MON4D3/LuaSnip'
    use 'windwp/nvim-autopairs'
    -- AI Completion
    -- use {
    --     'tzachar/cmp-tabnine',
    --     run = './install.sh',
    --     requires = 'hrsh7th/nvim-cmp',
    --     config = [[require('configs.tabnine')]],
    -- }
    use { 'github/copilot.vim', opt = true }

    -- Comment
    use 'numToStr/Comment.nvim'

    -- GUI
    use 'nvim-lualine/lualine.nvim' -- 底部状态栏
    use 'declancm/cinnamon.nvim' -- smooth scroll
    

    -- Writting
    use 'lukas-reineke/indent-blankline.nvim' -- Indent
    use { 'junegunn/limelight.vim', requires = 'junegunn/goyo.vim' } -- another zen mode
    use 'kylechui/nvim-surround' -- 修改包围符合
    use 'wellle/targets.vim' -- 修改包围内内容
    use 'MiuKaShi/bibtexcite.vim' -- bib 引用
    
    use { 'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()' }
	use 'stevearc/aerial.nvim' --outline
    -- use {
    --     'nvim-neorg/neorg', -- org 模式
    --     tag = '0.0.11',
    --     requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' },
    --     config = [[require('configs.neorg')]],
    -- }

    -- Search
    -- use 'easymotion/vim-easymotion' -- 单词搜索
    use { 'ggandor/leap.nvim', config = [[require('leap').set_default_keymaps()]] }
    use { 'junegunn/fzf', dir = '~/.fzf', run = ':call fzf#install()' } -- fuzzy 查找
    use 'junegunn/fzf.vim' -- needed for previews
    use 'Avi-D-coder/fzf-wordnet.vim' -- 英文词典
    use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim' -- 选择框 vim.ui.select

    -- File manager
    use 'is0n/fm-nvim'

    -- Language
    use 'JuliaEditorSupport/julia-vim' --Julia

    -- Others
    use 'folke/which-key.nvim' -- 快捷键 maps
    use 'h-hg/fcitx.nvim' -- fcitx5 自动切换
    use 'wakatime/vim-wakatime'
    use 'MiuKaShi/vim-gf-list' -- gf 自定义
    use 'justinmk/vim-gtfo' -- gf打开文件
    use 'skywind3000/asyncrun.vim' -- 异步运行
end)
