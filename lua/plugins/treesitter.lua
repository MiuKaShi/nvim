local ensureInstalled = {
  "zsh",
  "bash",
  "python",
  "requirements",
  "query",
  "c",
  "cpp",
  "cmake",
  "comment",
  "diff",
  "dockerfile",
  "go",
  "json",
  "latex",
  "lua",
  "luap",
  "luadoc",
  "foam",
  "toml",
  "yaml",
  "julia",
  "matlab",
  "http",
  "glsl",
  "ruby",
  "rust",
  "regex",
  "vim",
  "vimdoc",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    -- dependencies = {
    --   "hiphish/rainbow-delimiters.nvim", -- WARN This degrades performance
    -- },
    opts = {
      install_dir = vim.fn.stdpath "data" .. "/treesitter",
      highlight = {
        enable = true,
        disable = {
          "css",
          "latex",
          "markdown",
          -- "python",
        },
        -- additional_vim_regex_highlighting = { "org" },
      },
      autopairs = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = "<TAB>",
        },
        is_supported = function()
          local mode = vim.api.nvim_get_mode().mode
          if mode == "c" then return false end
          return true
        end,
      },
      indent = { enable = false },
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        include_match_words = true,
        disable = { "bash" },
      },
      rainbow = {
        enable = true,
        disable = { "jsx" },
      },
    },
    init = function()
      -- auto-install parsers
      if vim.fn.executable "tree-sitter" == 1 then
        vim.defer_fn(function() require("nvim-treesitter").install(ensureInstalled) end, 2000)
      else
        local msg = "`tree-sitter-cli` not found. Skipping auto-install of parsers."
        vim.notify(msg, vim.log.levels.WARN, { title = "Treesitter" })
      end

      -- auto-start highlights & indentation
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Enable treesitter-based features for supported filetypes",
        callback = function(ctx)
          -- highlights
          -- errors for filetypes with no parser
          local hasStarted = pcall(vim.treesitter.start, ctx.buf)
          -- indent
          local dontUseTreesitterIndent = { "zsh", "bash", "markdown", "javascript" }
          if hasStarted and not vim.list_contains(dontUseTreesitterIndent, ctx.match) then
            vim.bo[ctx.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
          end
        end,
      })

      -- comments parser
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        desc = "User: highlights for the Treesitter `comments` parser",
        callback = function()
          -- FIX todo-comments in languages where LSP overwrites their highlight
          -- https://github.com/stsewd/tree-sitter-comment/issues/22
          -- https://github.com/LuaLS/lua-language-server/issues/1809
          vim.api.nvim_set_hl(0, "@lsp.type.comment", {})

          -- Define `@comment.bold` for `queries/comment/highlights.scm`
          vim.api.nvim_set_hl(0, "@comment.bold", { bold = true })
        end,
      })
    end,
  },

  -- tons of text objects
  {
    "chrisgrieser/nvim-various-textobjs",
    keys = {
			-- stylua: ignore start
			{ "iv", "<cmd>lua require('various-textobjs').value('inner')<CR>", mode = { "x", "o" }, desc = "󱡔 inner value" },
			{ "av", "<cmd>lua require('various-textobjs').value('outer')<CR>", mode = { "x", "o" }, desc = "󱡔 outer value" },
			{ "ak", "<cmd>lua require('various-textobjs').key('inner')<CR>", mode = { "x", "o" }, desc = "󱡔 outer key" },

			{ "n", "<cmd>lua require('various-textobjs').nearEoL()<CR>", mode = "o", desc = "󱡔 near EoL" },
			{ "m", "<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>", mode = { "o", "x" }, desc = "󱡔 to next closing bracket" },
			{ "w", "<cmd>lua require('various-textobjs').toNextQuotationMark()<CR>", mode = "o", desc = "󱡔 to next quote", nowait = true },
			{ "k", "<cmd>lua require('various-textobjs').anyQuote('inner')<CR>", mode = "o", desc = "󱡔 inner anyquote" },
			{ "K", "<cmd>lua require('various-textobjs').anyQuote('outer')<CR>", mode = "o", desc = "󱡔 outer anyquote" },

			-- INFO not setting in visual mode, to keep visual block mode replace
			{ "rv", "<cmd>lua require('various-textobjs').restOfWindow()<CR>", mode = "o", desc = "󱡔 rest of viewport" },
			{ "rp", "<cmd>lua require('various-textobjs').restOfParagraph()<CR>", mode = "o", desc = "󱡔 rest of paragraph" },
			{ "ri", "<cmd>lua require('various-textobjs').restOfIndentation()<CR>", mode = "o", desc = "󱡔 rest of indentation" },
			{ "rg", "G", mode = "o", desc = "󱡔 rest of buffer" },
			{ "gg", "<cmd>lua require('various-textobjs').entireBuffer()<CR>", mode = { "x", "o" }, desc = "󱡔 entire buffer" },

			{ "ge", "<cmd>lua require('various-textobjs').diagnostic()<CR>", mode = { "x", "o" }, desc = "󱡔 diagnostic" },
			{ "L", "<cmd>lua require('various-textobjs').url()<CR>", mode = "o", desc = "󱡔 link" },
			{ "o", "<cmd>lua require('various-textobjs').column()<CR>", mode = "o", desc = "󱡔 column" },
			{ "u", "<cmd>lua require('various-textobjs').multiCommentedLines()<CR>", mode = "o", desc = "󱡔 multi-line-comment" },
			{ "in", "<cmd>lua require('various-textobjs').number('inner')<CR>", mode = { "x", "o" }, desc = "󱡔 inner number" },
			{ "an", "<cmd>lua require('various-textobjs').number('outer')<CR>", mode = { "x", "o" }, desc = "󱡔 outer number" },

			{ "ii", "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>", mode = { "x", "o" }, desc = "󱡔 inner indent" },
			{ "ai", "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>", mode = { "x", "o" }, desc = "󱡔 outer indent" },
			{ "aj", "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>", mode = { "x", "o" }, desc = "󱡔 top-border indent" },
			{ "ig", "<cmd>lua require('various-textobjs').greedyOuterIndentation('inner')<CR>", mode = { "x", "o" }, desc = "󱡔 inner greedy indent" },
			{ "ag", "<cmd>lua require('various-textobjs').greedyOuterIndentation('outer')<CR>", mode = { "x", "o" }, desc = "󱡔 outer greedy indent" },

			{ "i.", "<cmd>lua require('various-textobjs').chainMember('inner')<CR>", mode = { "x", "o" }, desc = "󱡔 inner indent" },
			{ "a.", "<cmd>lua require('various-textobjs').chainMember('outer')<CR>", mode = { "x", "o" }, desc = "󱡔 outer indent" },

			-- python
			{ "iy", "<cmd>lua require('various-textobjs').pyTripleQuotes('inner')<CR>", ft = "python", mode = { "x", "o" }, desc = "󱡔 inner tripleQuotes" },
			{ "ay", "<cmd>lua require('various-textobjs').pyTripleQuotes('outer')<CR>", ft = "python", mode = { "x", "o" }, desc = "󱡔 outer tripleQuotes" },

			-- markdown
			{ "il", "<cmd>lua require('various-textobjs').mdlink('inner')<CR>", mode = { "x", "o" }, ft = "markdown", desc = "󱡔 inner md link" },
			{ "al", "<cmd>lua require('various-textobjs').mdlink('outer')<CR>", mode = { "x", "o" }, ft = "markdown", desc = "󱡔 outer md link" },
			{ "ic", "<cmd>lua require('various-textobjs').mdFencedCodeBlock('inner')<CR>", mode = { "x", "o" }, ft = "markdown", desc = "󱡔 inner CodeBlock" },
			{ "ac", "<cmd>lua require('various-textobjs').mdFencedCodeBlock('outer')<CR>", mode = { "x", "o" }, ft = "markdown", desc = "󱡔 outer CodeBlock" },

			-- shell
			{ "i|", "<cmd>lua require('various-textobjs').shellPipe('inner')<CR>", mode = { "x", "o" }, ft = "sh", desc = "󱡔 inner pipe" },
      -- stylua: ignore end
    },
  },

  -- {
  --   "HiPhish/rainbow-delimiters.nvim",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   event = "VeryLazy",
  --   init = function()
  --     local rainbow_delimiters = require "rainbow-delimiters"
  --     vim.g.rainbow_delimiters = {
  --       strategy = {
  --         [""] = rainbow_delimiters.strategy["global"],
  --         vim = rainbow_delimiters.strategy["local"],
  --       },
  --       query = {
  --         [""] = "rainbow-delimiters",
  --         lua = "rainbow-blocks",
  --       },
  --       highlight = {
  --         "RainbowDelimiterRed",
  --         "RainbowDelimiterYellow",
  --         "RainbowDelimiterBlue",
  --         "RainbowDelimiterOrange",
  --         "RainbowDelimiterGreen",
  --         "RainbowDelimiterViolet",
  --         "RainbowDelimiterCyan",
  --       },
  --     }
  --   end,
  -- },

  -- {
  --   "sustech-data/wildfire.nvim",
  --   event = "VeryLazy",
  --   dependencies = "nvim-treesitter",
  --   config = function() require("wildfire").setup() end,
  -- },
}
