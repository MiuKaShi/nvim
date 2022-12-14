local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local PACKER_BOOTSTRAP
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
    use { 'dstein64/vim-startuptime', cmd = 'StartupTime' }

    -- GUI
    use { 'lukas-reineke/indent-blankline.nvim', event = 'BufRead', config = "require('user.indentline').config()" } -- Indent
    use {
        'norcalli/nvim-colorizer.lua',
        event = { 'BufRead', 'BufNewFile' },
        config = "require('user.colorizer').config()",
    } -- editor 内颜色显示
    use 'ellisonleao/gruvbox.nvim'
    use 'nvim-lualine/lualine.nvim' -- 底部状态栏

    -- LSP
    use 'neovim/nvim-lspconfig' -- lsp 配置插件
    use 'tami5/lspsaga.nvim' -- LSP UI
    use 'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters
    use 'folke/neodev.nvim' -- lua 语法提示 for lsp

    -- Format
    use 'sbdchd/neoformat'
    use { 'junegunn/vim-easy-align', event = 'CursorHold' }

    -- Syntax
    use { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' }
    use { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        event = { 'BufRead', 'BufNewFile' },
        cmd = {
            'TSInstall',
            'TSInstallInfo',
            'TSInstallSync',
            'TSUninstall',
            'TSUpdate',
            'TSUpdateSync',
            'TSDisableAll',
            'TSEnableAll',
        },
        config = "require('user.treesitter').config()",
    }
    use { 'luochen1990/rainbow', ft = 'matlab' } -- 补充ts-rainbow不支持的language

    -- Completion
    use { 'rafamadriz/friendly-snippets', event = 'InsertEnter' }
    use { 'L3MON4D3/LuaSnip', after = 'friendly-snippets' }
    use { 'hrsh7th/nvim-cmp', after = 'LuaSnip', config = "require('user.cmp').config()" }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'lukas-reineke/cmp-rg', after = 'nvim-cmp' }
    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
    use { 'mstanciu552/cmp-matlab', after = 'nvim-cmp' }

    -- AI Completion
    use 'zbirenbaum/copilot.lua'
    use 'zbirenbaum/copilot-cmp'
    -- use {
    --     'tzachar/cmp-tabnine',
    --     run = './install.sh',
    -- }
    --

    -- Icons
    use { 'kyazdani42/nvim-web-devicons', event = 'VimEnter', config = "require('user.icons').config()" }

    -- Search
    use 'kkharji/sqlite.lua'
    use { 'nvim-lua/plenary.nvim', module = 'plenary' }
    use {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        module = 'telescope',
        requires = {
            'nvim-telescope/telescope-file-browser.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-telescope/telescope-frecency.nvim',
        },
        config = "require('user.telescope').config()",
    }

    -- File manager
    use 'is0n/fm-nvim'

    -- markdown
    use {
        'iamcco/markdown-preview.nvim',
        config = "require('user.mkdp').config()",
        run = 'cd app && npm install',
        cmd = 'MarkdownPreview',
        ft = 'markdown',
    }
    use { 'vim-pandoc/vim-pandoc-syntax', ft = 'markdown' } -- markdown 高亮
    use { 'MiuKaShi/bibtexcite.vim', ft = 'markdown' } -- bib 引用
    use { 'epwalsh/obsidian.nvim', ft = 'markdown' } -- notes
    use { 'Avi-D-coder/fzf-wordnet.vim', requires = 'junegunn/fzf.vim', ft = 'markdown' } -- en dict
    -- use {
    --     'nvim-neorg/neorg', -- org 模式
    --     tag = '0.0.11',
    --     requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' },
    --     config = [[require('configs.neorg')]],
    -- }

    -- Utils
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = "require('user.autopairs').config()",
    }
    use 'kylechui/nvim-surround' -- 修改包围符合
    use {
        'stevearc/aerial.nvim',
        module = 'aerial',
        cmd = { 'AerialToggle', 'AerialOpen', 'AerialInfo' },
        config = "require('user.aerial').config()",
    } -- outline
    use 'numToStr/Comment.nvim' -- comment
    use 'ggandor/leap.nvim' -- quick move
    use 'folke/which-key.nvim' -- 快捷键 maps
    use 'h-hg/fcitx.nvim' -- fcitx5 自动切换
    use 'wakatime/vim-wakatime' -- time tracker
    use 'MiuKaShi/vim-gf-list' -- gf 自定义
    use 'justinmk/vim-gtfo' -- gf打开文件
    use 'skywind3000/asyncrun.vim' -- 异步运行

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
