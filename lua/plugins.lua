local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print 'Installing packer close and reopen Neovim...'
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'rounded' }
        end,
    },
}

-- Install your plugins here
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    -- GUI
    use 'lukas-reineke/indent-blankline.nvim' -- Indent
    use 'ellisonleao/gruvbox.nvim'
    use 'norcalli/nvim-colorizer.lua' -- editor 内颜色显示
    use 'nvim-lualine/lualine.nvim' -- 底部状态栏
    use 'declancm/cinnamon.nvim' -- smooth scroll

    -- LSP
    use 'neovim/nvim-lspconfig' -- lsp 配置插件
    use 'tami5/lspsaga.nvim' -- LSP UI
    use 'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters
    use 'folke/neodev.nvim' -- lua 语法提示 for lsp
    use 'sbdchd/neoformat'

    -- Format
    --use 'sbdchd/neoformat'
    use 'junegunn/vim-easy-align'

    -- Syntax
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground', opt = true }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'p00f/nvim-ts-rainbow'
    use 'luochen1990/rainbow' -- 嵌套括号高亮
    use 'lambdalisue/vim-cython-syntax'
    use 'vim-pandoc/vim-pandoc-syntax' -- markdown 高亮

    -- Completion
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            {
                'hrsh7th/cmp-cmdline',
                after = 'nvim-cmp',
                commit = 'd2dfa338520c99c1f2dc6af9388de081a6e63296',
            },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'lukas-reineke/cmp-rg', after = 'nvim-cmp' },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            { 'mstanciu552/cmp-matlab', after = 'nvim-cmp' },
        },
    }
    use 'windwp/nvim-autopairs'
    use { 'github/copilot.vim', opt = true }
    -- AI Completion
    -- use {
    --     'tzachar/cmp-tabnine',
    --     run = './install.sh',
    --     requires = 'hrsh7th/nvim-cmp',
    --     config = [[require('configs.tabnine')]],
    -- }

    -- Comment
    use 'numToStr/Comment.nvim'

    -- notes
    use 'epwalsh/obsidian.nvim'

    -- Writting
    use 'kylechui/nvim-surround' -- 修改包围符合
    use 'wellle/targets.vim' -- 修改包围内内容
    use 'MiuKaShi/bibtexcite.vim' -- bib 引用
    use 'stevearc/aerial.nvim' --outline
    use { 'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()' }
    -- use {
    --     'nvim-neorg/neorg', -- org 模式
    --     tag = '0.0.11',
    --     requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' },
    --     config = [[require('configs.neorg')]],
    -- }

    -- Search
    use 'ggandor/leap.nvim' -- word search
    use 'junegunn/fzf.vim' -- needed for previews
    use 'Avi-D-coder/fzf-wordnet.vim' -- 英文词典
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
        },
    }
    use {
        'nvim-telescope/telescope-frecency.nvim',
        requires = 'kkharji/sqlite.lua',
    }
    use 'nvim-telescope/telescope-file-browser.nvim' -- file select
    use 'nvim-telescope/telescope-ui-select.nvim' -- 选择框 vim.ui.select

    -- File manager
    use 'is0n/fm-nvim'

    -- Language
    use 'JuliaEditorSupport/julia-vim' --Julia
    -- use 'kdheepak/JuliaFormatter.vim' -- Julia formatter

    -- Others
    use 'folke/which-key.nvim' -- 快捷键 maps
    use 'h-hg/fcitx.nvim' -- fcitx5 自动切换
    use 'wakatime/vim-wakatime'
    use 'MiuKaShi/vim-gf-list' -- gf 自定义
    use 'justinmk/vim-gtfo' -- gf打开文件
    use 'skywind3000/asyncrun.vim' -- 异步运行

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
