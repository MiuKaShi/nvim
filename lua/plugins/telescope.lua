local Util = require "util"

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
  },
  config = function(_, _)
    -- local fb_actions = require("telescope._extensions.file_browser.actions")
    local home = os.getenv "HOME"
    local themes = require "telescope.themes"
    local opts = {
      defaults = {
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
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
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
        live_grep = { path_display = { "shorten" } },
      },
      extensions = {
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
      "file_browser",
      "frecency",
      "ui-select",
    }
    for _, extn in ipairs(extns) do
      telescope.load_extension(extn)
    end
  end,
  keys = {
    { "<leader>/", Util.tele_builtin("live_grep", { previewer = false }), desc = "Grep search" },
    { "<leader>fb", Util.tele_builtin "buffers", desc = "buffer list" },
    { "<leader>fs", Util.tele_builtin "lsp_document_symbols", desc = "󰒕 Symbols" },
    { "<leader>fc", Util.tele_builtin "colorscheme", desc = "Colorscheme" },
    { "<leader>fw", Util.tele_builtin "grep_string", desc = "Find cursor word" },
    { "<leader>ff", Util.tele_builtin "find_files", desc = "Find Files" },
    { "<leader>fm", Util.tele_builtin "builtin", desc = "Telescope Meta" },
    { "<leader>fh", Util.tele_builtin "help_tags", desc = "Help Tags" },
    { "<C-f>", Util.tele_builtin "current_buffer_fuzzy_find", desc = "Search current buffer" },
    { "z=", "<cmd>Telescope spell_suggest<CR>", desc = "Spell suggest" },
    {
      "<leader>fr",
      function() require("telescope").extensions.frecency.frecency() end,
      desc = "Recent Files",
    },
  },
}
