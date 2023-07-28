return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "InsertEnter",
    config = function()
      local null_ls = require "null-ls"
      local helpers = require "null-ls.helpers"
      local methods = require "null-ls.methods"
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local mh_style = {
        name = "mh_style",
        meta = {
          url = "https://github.com/florianschanda/miss_hit",
          description = "formatter for matlab",
        },
        method = methods.internal.FORMATTING,
        filetypes = { "matlab" },
        generator_opts = {
          command = "/home/miuka/.local/bin/mh_style",
          args = { "--input-encoding=utf-8", "--fix", "$FILENAME" },
          to_temp_file = true,
        },
        factory = helpers.formatter_factory,
      }

      local sources = {
        --formatter
        -- css json markdown yaml
        formatting.prettierd.with {
          filetypes = { "css", "json", "yaml", "markdown" },
        },
        -- c
        formatting.astyle.with {
          filetypes = { "c" },
          extra_args = {
            "--mode=c",
            "--indent=spaces=4",
            "--convert-tabs",
            "--pad-oper",
            "--indent-col1-comments",
            "--unpad-paren",
            "--max-code-length=120",
            "--add-one-line-brackets",
            "--style=linux",
            "--indent-classes",
            "--keep-one-line-statements",
            "--add-brackets",
            "--pad-header",
            "--break-blocks",
            "--indent=spaces=4",
            "--convert-tabs",
            "--break-after-logical",
            "--min-conditional-indent=2",
            "--max-instatement-indent=40",
            "--keep-one-line-blocks",
          },
        },
        -- Latex
        formatting.latexindent,
        -- CMake
        formatting.cmake_format,
        -- Fortran
        formatting.fprettify.with {
          extra_args = {
            "--indent",
            "4",
            "--whitespace",
            "3",
            "--strict-indent",
            "--enable-decl",
            "--case",
            "1",
            "1",
            "1",
            "0",
          },
        },
        -- python
        formatting.black.with { extra_args = { "--fast" } },
        -- lua
        formatting.stylua.with {
          extra_args = { "--config-path", vim.fn.expand "~/.config/stylua/stylua.toml" },
        },
        formatting.shfmt.with {
          extra_args = { "-i", "4", "-ci", "-bn" },
        },

        --diagnostics
        -- MATLAB
        diagnostics.mlint,
        helpers.make_builtin(mh_style),
        -- markdown
        diagnostics.markdownlint.with {
          args = {
            "--config",
            "~/.config/markdownlint/markdownlint.yaml",
            "--stdin",
          },
        },
      }
      null_ls.setup {
        debug = false,
        sources = sources,
        on_attach = function(client, bufnr)
          if client.server_capabilities.documentFormattingProvider then
            vim.keymap.set(
              "n",
              "<leader>bf",
              function() vim.lsp.buf.format { async = true } end,
              { buffer = bufnr, desc = "Formmating" }
            )
          end
          if client.server_capabilities.documentRangeFormattingProvider then
            vim.keymap.set("v", "<leader>bf", vim.lsp.buf.format, { buffer = bufnr, desc = "Range Formmating" })
          end
        end,
      }
    end,
  },
}
