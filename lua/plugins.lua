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
    require('user.indentline').config()
    use {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufRead', 'BufNewFile' },
        config = "require('user.indentline').setup()",
    } -- Indent
    use {
        'norcalli/nvim-colorizer.lua',
        event = { 'BufRead', 'BufNewFile' },
        config = "require('user.colorizer').setup()",
    } -- editor 内颜色显示

    use 'ellisonleao/gruvbox.nvim'

    use {
        'nvim-lualine/lualine.nvim',
        config = "require('user.lualine').setup()",
    } -- 底部状态栏
    -- LSP
    use 'neovim/nvim-lspconfig' -- lsp 配置插件
    use 'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters
    use 'folke/neodev.nvim' -- lua 语法提示 for lsp

    require('user.lsp.lspsaga').config()
    use {
        'glepnir/lspsaga.nvim',
        config = "require('user.lsp.lspsaga').setup()",
        cmd = { 'Lspsaga' },
    } -- better LSP

    require('user.trouble').config()
    use {
        'folke/trouble.nvim',
        config = "require('user.trouble').setup()",
        cmd = { 'TroubleToggle', 'Trouble' },
    } -- trouble

    -- Format
    require('user.neoformat').config()
    use { 'sbdchd/neoformat', cmd = 'Neoformat' }

    require('user.easyalign').config()
    use { 'junegunn/vim-easy-align', opt = true, cmd = 'EasyAlign' }

    -- Syntax
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
        config = "require('user.treesitter').setup()",
    }
    use { 'HiPhish/nvim-ts-rainbow2', after = 'nvim-treesitter' }
    use { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' }
    require('user.rainbow').config()
    use { 'luochen1990/rainbow', ft = 'matlab' } -- 补充ts-rainbow不支持的language

    -- CMP&Editor
    use { 'L3MON4D3/LuaSnip', event = 'InsertEnter' }
    use { 'hrsh7th/nvim-cmp', after = 'LuaSnip', module = 'cmp', config = "require('user.cmp').setup()" }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'lukas-reineke/cmp-rg', after = 'nvim-cmp' }
    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
    use { 'mstanciu552/cmp-matlab', after = 'nvim-cmp' }
    use { 'kdheepak/cmp-latex-symbols', after = 'nvim-cmp' }

    use {
        'windwp/nvim-autopairs',
        after = 'nvim-cmp',
        config = "require('user.autopairs').setup()",
    }
    use {
        'kylechui/nvim-surround',
        after = 'nvim-cmp',
        config = "require('user.surround').setup()",
    } -- 修改包围符合

    -- AI
    use {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        config = "require('user.copilot').setup()",
    }
    use { 'zbirenbaum/copilot-cmp', module = 'copilot_cmp' }
    -- use {
    --     'tzachar/cmp-tabnine',
    --     run = './install.sh',
    -- }
    -- use {
    --     'jackMort/ChatGPT.nvim',
    --     config = "require('user.chatgpt').setup()",
    --     event = 'InsertEnter',
    -- }
    -- use { 'MunifTanjim/nui.nvim', after = 'ChatGPT.nvim' }

    -- Icons
    use { 'kyazdani42/nvim-web-devicons', event = 'VimEnter', config = "require('user.icons').setup()" }

    -- Search/replace
    use { 'kkharji/sqlite.lua', module = 'sqlite' } -- for telescope-frecency
    use { 'nvim-lua/plenary.nvim', module = 'plenary' }

    use {
        'nvim-telescope/telescope.nvim',
        config = "require('user.telescope').setup()",
        after = 'nvim-cmp',
        keys = {
            'ms',
            '<leader>fr',
            '<leader>fs',
            '<leader>/',
            '<leader>fl',
            '<leader>fw',
            '<leader>ff',
            '<leader>fm',
            '<leader>fh',
            '<leader>bl',
            '<leader>gc',
            '<leader>gb',
            '<leader>sr',
            '<C-f>',
        },
    }
    use { 'nvim-telescope/telescope-file-browser.nvim', module = 'telescope._extensions.file_browser' }
    use { 'nvim-telescope/telescope-ui-select.nvim', module = 'telescope._extensions.ui-select' }
    use { 'nvim-telescope/telescope-frecency.nvim', module = 'telescope._extensions.frecency' }
    use { 'tom-anders/telescope-vim-bookmarks.nvim', module = 'telescope._extensions.vim_bookmarks' }
    use { 'windwp/nvim-spectre', module = 'spectre' }

    --Bookmarks
    use { 'mattesgroeger/vim-bookmarks', after = 'telescope.nvim' }

    -- File manager
    use {
        'is0n/fm-nvim',
        config = "require('user.fm').setup()",
        cmd = 'Lf',
    }

    -- markdown
    use { 'vim-pandoc/vim-pandoc-syntax', ft = 'markdown.pandoc' } -- markdown 高亮
    require('user.mkdp').config()
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && npm install',
        setup = function()
            vim.g.mkdp_filetypes = { 'markdown.pandoc' }
        end,
        ft = { 'markdown.pandoc' },
    }

    require('user.obsidian').config()
    use {
        'epwalsh/obsidian.nvim',
        config = "require('user.obsidian').setup()",
        cmd = {
            'ObsidianFollowLink',
            'ObsidianLink',
            'ObsidianLinkNew',
            'ObsidianQuickSwitch',
            'ObsidianSearch',
            'ObsidianBacklinks',
            'ObsidianOpen',
            'ObsidianNew',
            'ObsidianLinkNew',
        },
    } -- notes
    require('user.bibtexcite').config()
    use {
        'MiuKaShi/bibtexcite.vim',
        cmd = { 'BibtexciteInsert', 'BibtexciteShowcite', 'BibtexciteOpenfile' },
    } -- bib 引用
    use { 'junegunn/fzf.vim', event = 'InsertEnter' }
    use { 'Avi-D-coder/fzf-wordnet.vim', after = 'fzf.vim' } -- en dic00t
    -- use {
    --     'nvim-neorg/neorg', -- org 模式
    --     tag = '0.0.11',
    --     requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' },
    --     config = [[require('configs.neorg')]],
    -- }

    -- Editor
    use {
        'stevearc/aerial.nvim',
        module = 'aerial',
        cmd = { 'AerialToggle', 'AerialOpen', 'AerialInfo' },
        config = "require('user.aerial').setup()",
    } -- outline
    require('user.comment').config()
    use {
        'numToStr/Comment.nvim',
        config = "require('user.comment').setup()",
        event = { 'BufRead', 'BufNewFile' },
    } -- comment
    require('user.todo').config()
    use {
        'folke/todo-comments.nvim',
        event = { 'BufRead', 'BufNewFile' },
        cmd = { 'TodoTelescope' },
        config = "require('user.todo').setup()",
    } --Todo
    use {
        'ggandor/leap.nvim',
        event = 'InsertEnter',
        config = "require('user.leap').setup()",
    } -- quick move
    use {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
        config = "require('uer.diffview').setup()",
    } -- diffview

    require('user.mywords').config()
    use {
        'dwrdx/mywords.nvim',
        module = 'mywords',
        -- event = 'InsertEnter',
    } -- highlight words

    -- Utils
    use { 'h-hg/fcitx.nvim', event = 'InsertEnter' } -- fcitx5 自动切换
    use { 'wakatime/vim-wakatime', event = 'InsertEnter' } -- time tracker
    use { 'MiuKaShi/vim-gf-list', keys = 'gf' } -- gf 自定义
    -- use { 'skywind3000/asyncrun.vim', cmd = 'AsyncRun' } -- 异步运行

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
