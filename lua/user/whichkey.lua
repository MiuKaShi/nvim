local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '➜', -- symbol used between a key and it's label
        group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
        border = 'none', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = 'left', -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = 'auto', -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { 'j', 'k' },
        v = { 'j', 'k' },
    },
}

local opts = {
    mode = 'n', -- NORMAL mode
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    ['w'] = {
        name = '+Windows',
        s = { '<C-w>s', 'Split window below' },
        v = { '<C-w>v', 'Split window right' },
        ['-'] = { '<C-w>s', 'Split window below' },
        ['/'] = { '<C-w>v', 'Split window right' },
        w = { '<C-w>w', 'Other window' },
        j = { '<C-w>j', 'Go to the down window' },
        k = { '<C-w>k', 'Go to the up window' },
        h = { '<C-w>h', 'Go to the left window' },
        l = { '<C-w>l', 'Go to the right window' },
        q = { '<C-w>c', 'Close window' },
        m = { '<C-w>o', 'Maximize window' },
    },
    ['b'] = {
        name = '+Buffers',
        b = {
            "<cmd>lua require('telescope.builtin').buffers { sort_mru = true }<CR>",
            'List buffers',
        },
        n = { ':BufferLineCycleNext<CR>', 'Next buffer' },
        p = { ':BufferLineCyclePrev<CR>', 'Previous buffer' },
        d = { ':bw<CR>', 'Delete buffer' },
        c = { '<cmd>BibtexciteInsert<CR>', 'Bib citation insert' },
        v = { '<cmd>BibtexciteShowcite<CR>', 'Bib citation view' },
        o = { '<cmd>BibtexciteOpenfile<CR>', 'Bib Open pdf' },
    },
    ['p'] = {
        name = '+Projects',
        f = { '<cmd>Telescope find_files<CR>', 'Find file by name(<CTRL-P>)' },
        a = {
            '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
            'Add Workspace Folder',
        },
        r = {
            '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
            'Remove Workspace Folder',
        },
        l = {
            '<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>',
            'List Workspace Folder',
        },
    },
    ['j'] = {
        name = '+Jump',
        j = { '<Plug>(easymotion-s)', 'Jump to char' },
        l = { '<Plug>(easymotion-bd-jk)', 'Jump to line' },
        i = {
            "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>",
            'Jump to symbol',
        },
    },
    ['s'] = {
        name = '+Save/Symbols',
        s = { '<cmd>w ! sudo tee > /dev/null %<CR>', 'Force save file' },
    },
    ['g'] = {
        name = '+Git',
        s = { ':Magit<CR>', 'Magit status, see: vimagit' }, -- git状态显示
        g = { ':Flog<CR>', 'Show git commit graph' }, -- git图像显示
        c = {
            "<cmd> lua require('telescope.builtin').git_commits()<CR>",
            'Show commits(grep)',
        }, -- git commits 可过滤
        b = {
            "<cmd> lua require('telescope.builtin').git_branches()<CR>",
            'Show branches(grep)',
        }, -- git branchs 可过滤
    },
    ['e'] = {
        name = '+Errors',
        a = {
            "<cmd>lua require('telescope.builtin').diagnostics{ bufnr=0 }<CR>",
            'List all errors',
        },
        k = {
            '<cmd>lua vim.diagnostic.goto_prev()<CR>',
            'lspsaga.diagnostic PREV',
        },
        j = {
            '<cmd>lua vim.diagnostic.goto_next()<CR>',
            'lspsaga.diagnostic NEXT',
        },
        f = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Fix error' },
    },
    ['c'] = {
        name = '+Compiler',
        c = { ':!compiler <c-r>%<CR><CR>', 'Compiler files' },
        p = { ':silent !st autoprev <c-r>%<CR><CR>', 'Preivew files' },
        m = { ':MarkdownPreviewToggle <CR>', 'Markdown Preivew' },
    },
    [';'] = {
        name = 'comment',
        [';'] = { 'gcc<esc>', 'comment line', noremap = false, mode = 'v' },
    },
    t = { ':Lspsaga open_floaterm<CR>', 'Open Terminal(exit with <ESC>)' }, -- 打开终端
    l = { ':call ToggleHiddenAll()<CR>', 'LSP Toggle' }, -- LSP 开关
    i = { ':setlocal spell! spelllang=en_us<CR>', 'Spell Check Toggle' }, -- Spell check
    ['/'] = {
        ':Telescope live_grep previewer=false <CR>',
        'Fuzzy search in project',
    }, -- 项目内查找
    ['!'] = {
        ':Telescope help_tags theme=ivy<CR>',
        'Help commands by fuzzy search',
    }, -- vim帮助查找
    ['<Tab>'] = { ':b#<CR>', 'Last buffer' },
    ['<Space>'] = { ':Lf<CR>', 'Lf Toggle' }, -- 查找命令
}

which_key.setup(setup)
which_key.register(mappings, opts)
