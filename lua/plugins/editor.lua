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
      { "<leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle aerial" },
      { "[f", "<cmd>AerialPrev<CR>", desc = "Previous symbol" },
      { "]f", "<cmd>AerialNext<CR>", desc = "Next symbol" },
    },
  },

  -- diffview
  {
    "sindrets/diffview.nvim",
    opts = {
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_read = function()
          vim.opt_local.wrap = false
          vim.opt_local.list = false
          vim.opt_local.colorcolumn = "80"
          vim.opt_local.winbar = ""
        end,
      },
    },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", function() require("diffview").open {} end, desc = "Open Diffview" },
      { "<leader>gc", "<Cmd>DiffviewClose<CR>", desc = "Close Diffview" },
      { "<leader>gf", "<Cmd>DiffviewFileHistory<CR>", mode = { "n", "x" }, desc = "Close Diffview" },
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
    ft = {
      "sh",
      "c",
      "cpp",
      "matlab",
      "lua",
    },
    init = function()
      vim.g.matchup_surround_enabled = 1
      vim.g.matchup_transmute_enabled = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    config = function() vim.cmd "highlight MatchParen gui=italic,bold guifg=#cc241d guibg=#689d6a" end,
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
    "windwp/nvim-spectre",
    cmd = { "Spectre" },
    opts = { open_cmd = "noswapfile vnew" },
		-- stylua: ignore
    keys = {
      { "<leader>sp", function() require("spectre").toggle() end, desc = "Toggle Spectre" },
      { "<leader>sw", function() require("spectre").open_visual { select_word = true } end, desc = "Search current word" },
    },
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

  -- Multiple replacements
  {
    "AckslD/muren.nvim",
    config = true,
    cmd = { "MurenToggle", "MurenFresh", "MurenUnique" },
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
    ft = { "markdown" },
    config = function() require("markdowny").setup { remove_keymaps = true } end,
  },

  --  高亮
  { "vim-pandoc/vim-pandoc-syntax", ft = "markdown.pandoc" },

  -- 中文格式化
  {
    "hotoo/pangu.vim",
    cmd = { "Pangu", "PanguAll" },
    config = function() end,
  },

  -- Markdown预览
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview" },
    ft = { "markdown" },
    build = "cd app && npm install && git restore .",
    config = function()
      vim.cmd [[
function! g:Open_browser(url)
    execute "silent" "!WEBKIT_DISABLE_COMPOSITING_MODE=1 surf" a:url "&"
endfunction
]]
      vim.g.mkdp_browserfunc = "g:Open_browser"
      vim.g.mkdp_markdown_css = "/home/miuka/.config/nvim/markdown.css"
      vim.g.mkdp_highlight_css = "/home/miuka/.config/nvim/colors-light.css"
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
      "ObsidianLinkNew",
    },
    opts = {
      dir = "~/notes",
      completion = {
        nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
      },
      notes_subdir = "day_notes",
      note_id_func = function(title)
        local suffix = tostring(os.date "%Y%m%d%H%M%S")
        return suffix
      end,
      mappings = {},
    },
    keys = {
      { "<leader>nj", "<CMD>ObsidianFollowLink<CR>", desc = "[O]bsidian [F]ollow [L]ink" },
      { "<leader>nk", "<CMD>ObsidianBacklinks<CR>", desc = "[O]bsidian [B]acklinks" },
      { "<leader>no", "<CMD>ObsidianOpen<CR>", desc = "[O]bsidian [O]pen" },
      { "<leader>ns", "<CMD>ObsidianSearch<CR>", desc = "[O]bsidian [S]earch" },
      { "<leader>nn", "<CMD>ObsidianNew<CR>", desc = "[O]bsidian [N]ew" },
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

  -- {
  --   "chrisgrieser/nvim-origami",
  --   event = "BufReadPost", -- later will not save folds
  --   opts = true, -- needed
  -- },

  -- fold
  {
    "chrisgrieser/nvim-origami",
    event = "BufReadPost", -- later will not save folds
    opts = {
      setupFoldKeymaps = false,
    },
    keys = { { "<BS>", function() require("origami").h() end, desc = "toggle fold" } },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    config = function()
      local foldIcon = ""
      local hlgroup = "NonText"
      local function foldTextFormatter(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = "  " .. foldIcon .. "  " .. tostring(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, hlgroup })
        return newVirtText
      end
      require("ufo").setup {
        provider_selector = function(_, ft, _)
          local lspWithOutFolding = { "markdown", "bash", "sh", "bash", "zsh", "css", "html", "python" }
          if vim.tbl_contains(lspWithOutFolding, ft) then
            return { "treesitter", "indent" }
          else
            return { "lsp", "indent" }
          end
        end,
        close_fold_kinds = { "imports", "comment" },
        open_fold_hl_timeout = 500,
        fold_virt_text_handler = foldTextFormatter,
      }
    end,
		-- stylua: ignore
    keys = {
      { "zr", function() require("ufo").openFoldsExceptKinds { "comments" } end, silent = true, desc = "󰘖 󱃄 Open All Folds except comments" },
      { "zm", function() require("ufo").closeAllFolds() end, silent = true, desc = "󰘖 󱃄 Close All Folds" },
			{ "z1", function() require("ufo").closeFoldsWith(1) end, desc = "󰘖 󱃄 Close Level 1 Folds" },
			{ "z2", function() require("ufo").closeFoldsWith(2) end, desc = "󰘖 󱃄 Close Level 2 Folds" },
			{ "z3", function() require("ufo").closeFoldsWith(3) end, desc = "󰘖 󱃄 Close Level 3 Folds" },
			{ "z4", function() require("ufo").closeFoldsWith(4) end, desc = "󰘖 󱃄 Close Level 4 Folds" },
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
