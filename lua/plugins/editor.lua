return {

  -- auto pairs
  {
    "altermo/ultimate-autopair.nvim",
    config = true,
    event = { "InsertEnter", "CmdlineEnter" },
  },

  -- surround
  {
    "kylechui/nvim-surround",
    config = true,
    keys = {
      { "ys", desc = "󰅪 Add Surround Operator" },
      { "yS", desc = "󰅪 Surround to EoL" },
      { "ds", desc = "󰅪 Delete Surround Operator" },
      { "cs", desc = "󰅪 Change Surround Operator" },
      { "s", mode = "x", desc = "󰅪 Add Surround Operator" },
    },
  },

  -- symbols outline
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },
      icons = {
        Array = "󰅨 ",
        Boolean = " ",
        Class = " ",
        Constant = " ",
        Constructor = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = "󰡱 ",
        Interface = " ",
        Key = " ",
        Method = " ",
        Module = " ",
        Number = "󰎠 ",
        Null = "󰟢 ",
        Object = " ",
        Operator = " ",
        Property = " ",
        Reference = " ",
        Struct = " ",
        String = "󰅳 ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
      },
      filter_kind = {
        "Array",
        "Boolean",
        "Class",
        "Constant",
        "Constructor",
        "Enum",
        "EnumMember",
        "Event",
        "Field",
        "File",
        "Function",
        "Interface",
        "Key",
        "Method",
        "Module",
        "Namespace",
        "Null",
        "Number",
        "Object",
        "Operator",
        "Package",
        "Property",
        -- "String",
        "Struct",
        "TypeParameter",
        "Variable",
      },
      show_guides = true,
      layout = { min_width = 30, default_direction = "left" },
    },
    cmd = "AerialToggle",
    keys = {
      { "<leader>oa", "<cmd>AerialToggle<CR>", desc = "Toggle aerial" },
      { "[f", "<cmd>AerialPrev<CR>", desc = "Previous symbol" },
      { "]f", "<cmd>AerialNext<CR>", desc = "Next symbol" },
    },
  },

  -- Navigate with search labels
  {
    "folke/flash.nvim",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      highlight = {
        backdrop = false,
        matches = true,
        priority = 5000,
      },
      modes = {
        char = {
          enabled = false,
        },
        treesitter_search = {
          label = { before = true, after = true, style = "inline" },
          highlight = {
            backdrop = false,
            matches = false,
          },
        },
      },
    },
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- align
  {
    "Vonr/align.nvim",
		-- stylua: ignore
    keys = {
      { "aa", mode = { "x" }, function() require("align").align_to_char(1, true) end, silent = true },
      { "as", mode = { "x" }, function() require("align").align_to_char(2, true, true) end, silent = true },
      { "aw", mode = { "x" }, function() require("align").align_to_string(false, true, true) end, silent = true },
      { "ar", mode = { "x" }, function() require("align").align_to_string(true, true, true) end, silent = true },
    },
  },

  -- logical match
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "UIEnter" },
    init = function()
      vim.g.matchup_surround_enabled = 1
      vim.g.matchup_transmute_enabled = 1
      vim.g.matchup_matchparen_deferred = 1 --improves performance a bit
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    keys = {
      { "m", "<Plug>(matchup-%)", desc = "Goto Matching Bracket" },
    },
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- comment
  {
    "echasnovski/mini.comment",
    config = true,
    keys = {
      "gcc",
      { "gbc", mode = { "n", "x" } },
      { "gc", mode = { "n", "x" } },
    },
  },

  -- highlight words
  {
    "dwrdx/mywords.nvim",
    event = { "InsertEnter" },
		-- stylua: ignore
    keys = {
      { "<leader>hh", function() require("mywords").hl_toggle() end, silent = true, desc = "highlight words" },
      { "<leader>hx", function() require("mywords").uhl_all() end, silent = true, desc = "unhighlight words" },
    },
  },

  -- search/replace in multiple files
  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar" },
		-- stylua: ignore
    keys = {
      { "<leader>sr", ":GrugFar<CR>", desc = "Grug Far" },
    },
    config = function() require("grug-far").setup {} end,
  },
  -- split-join lines
  {
    "Wansmer/treesj",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<leader>s", function() require("treesj").toggle() end, desc = "󰗈 Split-join lines" },
    },
    opts = {
      use_default_keymaps = false,
      cursor_behavior = "start", -- start|end|hold
      max_join_length = 160,
      langs = {
        python = { -- python docstrings
          string_content = { both = { fallback = function() vim.cmd "normal! gww" end } },
        },
        comment = {
          source = { both = { fallback = function() vim.cmd "normal! gww" end } },
        },
        html = {
          fragment = { both = { fallback = function() vim.cmd "normal! gww" end } },
        },
        markdown_inline = {
          inline = { both = { fallback = function() vim.cmd "normal! gww" end } },
        },
        markdown = {
          element = { both = { fallback = function() vim.cmd "normal! gww" end } },
          list_marker_minus = { both = { fallback = function() vim.cmd "normal! gww" end } },
          list_marker_dot = { both = { fallback = function() vim.cmd "normal! gww" end } },
        },
      },
    },
  },

  -- word
  {
    "Avi-D-coder/fzf-wordnet.vim",
    dependencies = {
      "junegunn/fzf.vim",
    },
    config = function() vim.g.fzf_wordnet_preview_arg = "" end,
    keys = {
      { "<C-d>", "<Plug>(fzf-complete-wordnet)", mode = { "i" } },
    },
  },

  -- bib
  {
    "MiuKaShi/bibtexcite.vim",
    cmd = {
      "BibtexciteInsert",
      "BibtexciteShowcite",
      "BibtexciteOpenfile",
      "BibtexciteEditfile",
      "BibtexciteNote",
    },
    config = function()
      vim.g.bibtexcite_bibfile = "~/papers/bib/mybib.bib"
      vim.g.bibtexcite_floating_window_border = { "│", "─", "╭", "╮", "╯", "╰" }
      vim.g.bibtexcite_close_preview_on_insert = 1
    end,
    keys = {
      { "<leader>bo", "<CMD>BibtexciteOpenfile<CR>" }, -- Bib Open pdf
      { "<leader>bv", "<CMD>BibtexciteShowcite<CR>" }, -- Bib citation show
      { "<leader>be", "<CMD>BibtexciteEdit<CR>" }, -- Bib citation edit
      { "<leader>bn", "<CMD>BibtexciteNote<CR>" }, -- Bib citation note
    },
  },

  -- markdown
  {
    "MiuKaShi/markdowny.nvim",
    ft = { "markdown.pandoc" },
    lazy = true,
    config = function() require("markdowny").setup { remove_keymaps = true } end,
  },

  --  高亮
  { "vim-pandoc/vim-pandoc-syntax", ft = "markdown.pandoc" },

  -- 中文格式化
  {
    "MiuKaShi/pangu.vim",
    init = function()
      vim.g["pangu_rule_trailing_whitespace"] = 0 -- 删除前置空白和尾空白。默认开启
      vim.g["pangu_rule_english_writing"] = 1 -- 英文写作模式。默认开启
    end,
    cmd = { "Pangu", "PanguAll" },
    config = function() end,
  },

  -- Markdown预览
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    lazy = false,
    build = "cd app && npm install && git restore .",
    config = function()
      vim.cmd [[
function! g:Open_browser(url)
    execute "silent" "!WEBKIT_DISABLE_COMPOSITING_MODE=1 surf" a:url "&"
endfunction
]]
      vim.g.mkdp_browserfunc = "g:Open_browser"
      vim.g.mkdp_markdown_css = "/home/miuka/.config/nvim/markdown.css"
      vim.g.mkdp_highlight_css = "/home/miuka/.config/nvim/google-light.css"
      vim.g.mkdp_page_title = "${name}.md"
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        disable_filename = 0,
      }
    end,
  },

  -- obsidian
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre /home/miuka/notes/**.md" },
    cmd = {
      "ObsidianFollowLink",
      "ObsidianLink",
      "ObsidianLinkNew",
      "ObsidianQuickSwitch",
      "ObsidianSearch",
      "ObsidianBacklinks",
      "ObsidianOpen",
      "ObsidianNew",
      "ObsidianToday",
      "ObsidianLinkNew",
    },
    opts = {
      dir = "~/notes",
      notes_subdir = "day_notes",
      daily_notes = {
        folder = "day_notes",
        date_format = "%Y%m%d%H%M%S",
        template = nil,
      },
      new_notes_location = "notes_subdir",
      completion = {
        nvim_cmp = false, -- if using nvim-cmp, otherwise set to false
        min_chars = 2,
      },
      note_id_func = function(title)
        local suffix = tostring(os.date "%Y%m%d%H%M%S")
        return suffix
      end,
      disable_frontmatter = false,
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then note:add_alias(note.title) end
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
      mappings = {},
    },
    keys = {
      { "<leader>nj", "<CMD>ObsidianFollowLink<CR>", desc = "Obsidian Follow Link" },
      { "<leader>nk", "<CMD>ObsidianBacklinks<CR>", desc = "Obsidian Backlinks" },
      { "<leader>no", "<CMD>ObsidianOpen<CR>", desc = "Obsidian Open" },
      { "<leader>nt", "<CMD>ObsidianTags<CR>", desc = "Obsidian Tag" },
      { "<leader>ns", "<CMD>ObsidianSearch<CR>", desc = "Obsidian Search" },
      { "<leader>nn", "<CMD>ObsidianNew<CR>", desc = "Obsidian New" },
    },
  },

  -- undo history
  {
    "mbbill/undotree",
    config = function()
      vim.g.undotree_WindowLayout = 3
      vim.g.undotree_DiffpanelHeight = 10
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_DiffAutoOpen = 0
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_HelpLine = 1
    end,
    cmd = {
      "UndotreeToggle",
    },
    keys = {
      { "<leader>u", "<Cmd>UndotreeToggle<CR>", desc = "󰕌  Undotree" },
    },
  },

  -- fold
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    init = function()
      vim.opt.foldlevel = 99 -- disable vim's auto-fold
      vim.opt.foldlevelstart = 99
    end,
    opts = {
      foldtext = {
        padding = 2,
        lineCount = { template = "󰘖 %d" },
      },
      autoFold = {
        kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
      },
    },
    keys = { { "<BS>", function() require("origami").h() end, desc = "toggle fold" } },
  },

  -- convenience file operations
  {
    "chrisgrieser/nvim-genghis",
    dependencies = "stevearc/dressing.nvim",
    cmd = "Genghis",
    keys = {
			-- stylua: ignore start
			{"<C-p>", function() require("genghis").copyFilepath() end, desc = "󰞇 Copy path" },
			{"<C-t>", function() require("genghis").copyRelativePath() end, desc = "󰞇 Copy relative path" },
			{"<C-n>", function() require("genghis").copyFilename() end, desc = "󰞇 Copy filename" },
			{"<C-r>", function() require("genghis").renameFile() end, desc = "󰞇 Rename file" },

			{"<D-n>", function() require("genghis").createNewFile() end, desc = "󰞇 Create new file" },
			{"<C-d>", function() require("genghis").duplicateFile() end, desc = "󰞇 Duplicate file" },
			{"<D-M>", function() require("genghis").moveToFolderInCwd() end, desc = "󰞇 Move file" },
			{"<leader>fx", function() require("genghis").moveSelectionToNewFile() end, mode = "x", desc = "󰞇 Selection to new file" },

			{"<leader>xx", function() require("genghis").chmodx() end, desc = "󰞇 chmod +x" },
      -- stylua: ignore end
    },
  },

  -- Zen mode
  -- {
  --   "folke/zen-mode.nvim",
  --   dependencies = {
  --     {
  --       "folke/twilight.nvim",
  --       opts = {
  --         dimming = {
  --           alpha = 0.25, -- amount of dimming
  --         },
  --         context = 3, -- amount of lines we will try to show around the current line
  --         treesitter = false,
  --       },
  --     },
  --     { "arnamak/stay-centered.nvim", config = function() require("stay-centered").setup() end },
  --   },
  --   keys = {
  --     { "<leader>zz", "<CMD>ZenMode<CR>" },
  --     { "<leader>zt", "<CMD>Twilight<CR>" },
  --   },
  --   opts = {
  --     window = {
  --       backdrop = 0.95,
  --       width = 120,
  --       height = 1,
  --       options = {
  --         signcolumn = "no", -- disable signcolumn
  --         number = false, -- disable number column
  --         relativenumber = false, -- disable relative numbers
  --         cursorline = false, -- disable cursorline
  --         cursorcolumn = false, -- disable cursor column
  --         foldcolumn = "0", -- disable fold column
  --         list = false, -- disable whitespace characters
  --       },
  --     },
  --     plugins = {
  --       options = {
  --         enabled = true,
  --         showcmd = true,
  --       },
  --       twilight = { enabled = true },
  --       gitsigns = { enabled = true },
  --       tmux = { enabled = true },
  --     },
  --   },
  -- },
}
