-- fuzzy finder
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "tsakirist/telescope-lazy.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function(_, _)
    -- local fb_actions = require("telescope._extensions.file_browser.actions")
    local home = os.getenv "HOME"
    local themes = require "telescope.themes"
    local opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        multi_icon = "󰒆 ",
        entry_prefix = "  ",
        results_title = false,
        dynamic_preview_title = true,
        preview = { timeout = 400, filesize_limit = 1 }, -- ms & Mb
        path_display = { "tail" },
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            height = { 0.75, min = 13 },
            width = 0.99,
            preview_cutoff = 70,
            preview_width = { 0.55, min = 30 },
          },
          vertical = {
            prompt_position = "top",
            mirror = true,
            height = 0.9,
            width = 0.7,
            preview_cutoff = 12,
            preview_height = { 0.4, min = 10 },
            anchor = "S",
          },
        },
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_ignore_patterns = {
          ".git/",
          "target/",
          "docs/",
          "vendor/*",
          "%.lock",
          "__pycache__/*",
          "%.sqlite3",
          "%.ipynb",
          "node_modules/*",
          "%.jpg",
          "%.jpeg",
          "%.png",
          "%.svg",
          "%.otf",
          "%.ttf",
          "%.webp",
          ".dart_tool/",
          ".github/",
          ".gradle/",
          ".idea/",
          ".settings/",
          ".vscode/",
          "__pycache__/",
          "build/",
          "env/",
          "gradle/",
          "node_modules/",
          "%.pdb",
          "%.dll",
          "%.class",
          "%.exe",
          "%.cache",
          "%.ico",
          "%.pdf",
          "%.dylib",
          "%.jar",
          "%.docx",
          "%.met",
          "smalljre_*/*",
          ".vale/",
          "%.burp",
          "%.mp4",
          "%.mkv",
          "%.rar",
          "%.zip",
          "%.7z",
          "%.tar",
          "%.bz2",
          "%.epub",
          "%.flac",
          "%.tar.gz",
        },
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<Esc>"] = require("telescope.actions").close,
          },
          n = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
      pickers = {
        buffers = { theme = "dropdown", sort_lastused = true, previewer = false },
        current_buffer_fuzzy_find = { previewer = false },
        find_files = {
          prompt_prefix = "󰝰 ",
          theme = "ivy",
          follow = true,
          hidden = true,
          find_command = {
            "rg",
            "--no-ignore",
            "--files",
            "--hidden",
            "--glob",
            "!.git/*",
            "--glob",
            "!**/.Rproj.user/*",
            "-L",
          },
        },
        git_files = { theme = "ivy" },
        grep_string = { path_display = { "shorten" } },
        live_grep = {
          prompt_prefix = " ",
          disable_coordinates = true,
          previewer = false,
          layout_config = { horizontal = { preview_width = 0.7 } },
        },
        lsp_references = {
          prompt_prefix = "󰈿 ",
          trim_text = true,
          show_line = false,
          include_declaration = false,
          include_current_line = false,
          initial_mode = "normal",
          layout_config = {
            horizontal = { preview_width = { 0.7, min = 30 } },
          },
        },
        lsp_definitions = {
          prompt_prefix = "󰈿 ",
          trim_text = true,
          show_line = false,
          initial_mode = "normal",
          layout_config = {
            horizontal = { preview_width = { 0.7, min = 30 } },
          },
        },
        treesitter = {
          prompt_prefix = " ",
          prompt_title = "Symbols",
          show_line = false,
          symbols = { "function", "class", "method" },
          symbol_highlights = { ["function"] = "Function" },
        },
        lsp_document_symbols = {
          prompt_prefix = "󰒕 ",
          symbols = { "function", "class", "method" },
          symbol_highlights = {
            ["module"] = "Comment",
            ["array"] = "Comment",
            ["object"] = "Comment",
            ["string"] = "Comment",
          },
        },
        lsp_workspace_symbols = {
          -- INFO workspace symbols are not working correctly in lua
          prompt_prefix = "󰒕 ",
          fname_width = 0, -- can see filename in preview title
          symbol_width = 25,
          ignore_symbols = { "variable", "constant", "property" },
          ignore_folders = {
            "node_modules", -- ts/js
            ".local", -- neodev.nvim
          },
        },
        spell_suggest = {
          initial_mode = "normal",
          prompt_prefix = "󰓆",
          previewer = false,
          theme = "cursor",
          layout_config = { cursor = { width = 0.3 } },
        },
        colorscheme = {
          enable_preview = true,
          prompt_prefix = " ",
          layout_config = {
            horizontal = {
              height = 0.4,
              width = 0.3,
              anchor = "SE",
              preview_width = 1, -- needs preview for live preview of the theme
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        frecency = {
          theme = themes.get_dropdown,
          show_scores = true,
          workspaces = {
            ["conf"] = home .. "/.config",
            ["note"] = home .. "/notes",
            ["proj"] = home .. "/Projects",
          },
        },
        file_browser = { theme = "ivy", hijack_netrw = true },
        ["ui-select"] = { themes.get_dropdown() },
      },
    }
    local telescope = require "telescope"
    telescope.setup(opts)
    local extns = {
      "fzf",
      "file_browser",
      "frecency",
      "ui-select",
    }
    for _, extn in ipairs(extns) do
      telescope.load_extension(extn)
    end
  end,
  keys = {
    { "<leader>/", function() vim.cmd.Telescope "live_grep" end, desc = "Grep search" },
    { "<leader>fb", function() vim.cmd.Telescope "buffers" end, desc = "buffer list" },
    { "<leader>fs", function() vim.cmd.Telescope "lsp_document_symbols" end, desc = "󰒕 Symbols" },
    { "<leader>fc", function() vim.cmd.Telescope "colorscheme" end, desc = "Colorscheme" },
    { "<leader>fw", function() vim.cmd.Telescope "grep_string" end, desc = "Find cursor word" },
    { "<leader>ff", function() vim.cmd.Telescope "find_files" end, desc = "Find Files" },
    { "<leader>fm", function() vim.cmd.Telescope "builtin" end, desc = "Telescope Meta" },
    { "<leader>fh", function() vim.cmd.Telescope "help_tags" end, desc = "Help Tags" },
    { "<C-f>", function() vim.cmd.Telescope "current_buffer_fuzzy_find" end, desc = "Search current buffer" },
    { "z=", function() vim.cmd.Telescope "spell_suggest" end, desc = "󰓆 Spell Suggest" },
    {
      "<leader>fr",
      function() require("telescope").extensions.frecency.frecency() end,
      desc = "Recent Files",
    },
  },
}
