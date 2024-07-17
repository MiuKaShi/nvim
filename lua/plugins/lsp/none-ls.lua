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
    args = { "--input-encoding=utf-8", "--fix", "--brief", "$FILENAME" },
    to_temp_file = true,
  },
  factory = helpers.formatter_factory,
}

local sources = {
  ---------formatter------------------
  -- css/json/markdown/yaml
  formatting.prettierd.with {
    filetypes = { "css", "json", "yaml", "markdown" },
    extra_args = {
      "--no-semi",
      "--single-quote",
      "--jsx-single-quote",
      -- "--prose-wrap=always",
    },
  },
  -- code blocks
  formatting.cbfmt,
  -- c/cpp/cxx
  formatting.astyle.with {
    filetypes = { "c", "cpp", "cxx" },
    extra_args = {
      "--style=kr",
      "--indent=spaces=4",
      "--attach-closing-while",
      "--indent-after-parens",
      "--indent-continuation=1",
      "--indent-labels",
      "--indent-col1-comments",
      "--min-conditional-indent=2",
      "--max-continuation-indent=40",
      "--convert-tabs",
      "--break-blocks",
      "--pad-oper",
      "--pad-comma",
      "--pad-header",
      "--unpad-paren",
      "--delete-empty-lines",
      "--align-pointer=name",
      "--align-reference=name",
      "--break-one-line-headers",
      "--remove-braces",
      "--convert-tabs",
      "--mode=c",
      "--suffix=none",
      "--errors-to-stdout",
      "--preserve-date",
    },
  },
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
  -- glsl
  -- formatting.clang_format.with {
  --   extra_args = { "-style=file:" .. vim.fn.expand "~/.config/clangd/.clang-format" },
  --   filetypes = { "glsl" },
  -- },
  -- python
  formatting.black.with { extra_args = { "--fast" } },
  -- lua
  formatting.stylua.with {
    extra_args = { "--config-path", vim.fn.expand "~/.config/stylua/stylua.toml" },
  },
  formatting.shfmt.with {
    extra_args = { "-i", "4", "-ci", "-bn" },
    extra_filetypes = { "zsh" },
  },
  -- LaTex
  -- require "none-ls.formatting.latexindent",
  -- Matlab
  helpers.make_builtin(mh_style),

  ---------diagnostics----------------
  -- MATLAB
  diagnostics.mlint.with {
    command = "/home/miuka/.local/MATLAB/R2024a/bin/glnxa64/mlint",
  },
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
  on_attach = function(client, bufnr) require("plugins.lsp.attach").on_attach(client, bufnr) end,
}
