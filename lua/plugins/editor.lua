return {

  -- auto pairs
  {
    "altermo/ultimate-autopair.nvim",
    config = true,
    event = { "InsertEnter" },
  },
  -- surround
  {
    "kylechui/nvim-surround",
    config = true,
    keys = { "cs", "ds", "ys", "yS" },
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
		-- stylua: ignore
		keys = {
			{ "<leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle aerial" },
			{ "[f",         "<cmd>AerialPrev<CR>",   desc = "Previous symbol" },
			{ "]f",         "<cmd>AerialNext<CR>",   desc = "Next symbol" },
		},
  },

  -- diffview
  {
    "sindrets/diffview.nvim",
    opts = { enhanced_diff_hl = true },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		-- stylua: ignore
		keys = { 
			{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diff View" },
			{ "<leader>gx", "<cmd>DiffviewClose<CR>", desc = "Diff Close" },
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
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "o", "x" }, function() require("flash").jump() end,       desc = "Flash" },
			{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		},
  },

  -- align
  {
    "Vonr/align.nvim",
    keys = {
      {
        "aa",
        mode = { "x" },
        function() require("align").align_to_char(1, true) end,
        silent = true,
      },
      {
        "as",
        mode = { "x" },
        function() require("align").align_to_char(2, true, true) end,
        silent = true,
      },
      {
        "aw",
        mode = { "x" },
        function() require("align").align_to_string(false, true, true) end,
        silent = true,
      },
      {
        "ar",
        mode = { "x" },
        function() require("align").align_to_string(true, true, true) end,
        silent = true,
      },
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
    keys = {
      {
        "<leader>hh",
        function() require("mywords").hl_toggle() end,
        silent = true,
        desc = "highlight words",
      },
      {
        "<leader>hx",
        function() require("mywords").uhl_all() end,
        silent = true,
        desc = "unhighlight words",
      },
    },
  },

  -- github copilot
  {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    cmd = "Copilot",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-y>",
          close = "<Esc>",
          next = "<C-z>",
          prev = "<C-x>",
          select = "<CR>",
          dismiss = "<C-c>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    },
    keys = {
      { "<leader>uc", function() require("copilot.suggestion").toggle_auto_trigger() end, desc = "Copilot toggle" },
    },
  },

  -- GPT
  {
    "james1236/backseat.nvim",
    cmd = {
      "Backseat",
      "BackseatAsk",
      "BackseatClear",
    },
    config = function()
      vim.g.backseat_openai_api_key = ""
      vim.g.backseat_openai_model_id = "gpt-3.5-turbo"
      vim.g.backseat_language = "chinese"
      vim.keymap.set("n", "<leader>ba", ":Backseat<CR>") -- auto comments
      vim.keymap.set("n", "<leader>bx", ":BackseatClear<CR>") -- clean comments
    end,
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    cmd = { "Spectre" },
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>sp", function() require("spectre").toggle() end, desc = "Toggle Spectre" },
      {
        "<leader>sw",
        function() require("spectre").open_visual { select_word = true } end,
        desc = "Search current word",
      },
    },
  },
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
  -- 表格
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    config = function() vim.keymap.set("n", "<leader>tt", ":TableModeToggle<cr>") end,
  },
  -- 预览
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview" },
    ft = { "markdown" },
    build = "cd app && npm install",
    config = function()
      vim.cmd [[
function! g:Open_browser(url)
    execute "silent" "!surf" a:url "&"
endfunction
]]
      vim.g.mkdp_browserfunc = "g:Open_browser"
      vim.g.mkdp_markdown_css = "/home/miuka/.config/nvim/markdown.css"
      -- vim.g.mkdp_highlight_css = '/home/miuka/.cache/wal/colors'
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
  -- obsidian
  {
    "mbbill/undotree",
    config = function()
      local util = require "util"
      local width = util.width()

      vim.g.undotree_SplitWidth = width
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_DiffAutoOpen = 0
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_HelpLine = 0
    end,
    cmd = {
      "UndotreeToggle",
    },
    keys = {
      { "<leader>u", "<Cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
    },
  },
  -- fold
  {
    "chrisgrieser/nvim-origami",
    event = "BufReadPost", -- later will not save folds
    opts = true, -- needed
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    config = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
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
          local lspWithOutFolding = { "markdown", "bash", "sh", "bash", "zsh", "css" }
          if vim.tbl_contains(lspWithOutFolding, ft) then
            return { "treesitter", "indent" }
          elseif ft == "html" then
            return { "indent" } -- lsp & treesitter do not provide folds
          else
            return { "lsp", "indent" }
          end
        end,
        close_fold_kinds = { "imports" },
        open_fold_hl_timeout = 500,
        fold_virt_text_handler = foldTextFormatter,
      }
    end,
  },
}
