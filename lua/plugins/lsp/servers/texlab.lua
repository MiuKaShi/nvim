local M = {}

M.setup = function(on_attach, capabilities)
  vim.lsp.config("texlab", {
    cmd = { "texlab" },
    filetypes = { "tex", "bib" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      texlab = {
        build = {
          executable = "tectonic",
          args = { "-X", "compile", "%f", "--synctex" },
          onSave = true,
        },
        forwardSearch = {
          executable = "zathura",
          args = {
            "--synctex-editor-command",
            [[nvim --headless -c "TexlabInverseSearch '%{input}' %{line}"]],
            "--synctex-forward",
            "%l:1:%f",
            "%p",
          },
        },
        chktex = { onOpenAndSave = false },
        diagnostics = { ignoredPatterns = { "^Overfull", "^Underfull" } },
        latexFormatter = "none",
        bibtexFormatter = "latexindent",
      },
    },
  })
end

return M
