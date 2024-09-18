local M = {}

function M.format()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format {
    bufnr = buf,
    filter = function(client)
      if have_nls then return client.name == "null-ls" end
      return client.name ~= "null-ls"
    end,
  }
end

function M.on_attach(client, buffer)
  vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"
  local keymaps = {
    { "K", vim.lsp.buf.hover, method = "hover" },
    { "gd", function() require("glance").open "definitions" end, method = "definition" },
    { "gt", function() require("glance").open "type_definitions" end, method = "typeDefinition" },
    { "gh", function() require("glance").open "references" end, method = "references" },
    { "gi", function() require("glance").open "implementations" end, method = "implementation" },
    { "gr", ":IncRename ", method = "rename" },
    { "gD", vim.lsp.buf.declaration, method = "declaration" },
    { "<C-k>", vim.lsp.buf.signature_help, method = "signatureHelp" },
    { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic", method = "diagnostic" },
    { "[d", vim.diagnostic.goto_prev, desc = "Prev Diagnostic", method = "diagnostic" },
    { "<leader>bf", M.format, desc = "Format", method = "formatting" },
    { "<leader>ca", vim.lsp.buf.code_action, mode = { "n", "v" }, method = "codeAction" },
    { "<leader>bf", M.format, desc = "Format Range", mode = "v", method = "rangeFormatting" },
  }

  for _, keys in ipairs(keymaps) do
    if client.supports_method("textDocument/" .. keys.method) then
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], { buffer = buffer, desc = keys.method })
    end
  end

  -- auto format
  M.autoformat = true
  vim.api.nvim_create_user_command("AutoFormatToggle", function()
    M.autoformat = not M.autoformat
    vim.notify("Format on save: " .. tostring(M.autoformat))
  end, {})
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buffer, {}),
      buffer = buffer,
      callback = function()
        if M.autoformat then M.format() end
      end,
    })
  end

  -- highlight hint
  if client.supports_method "textDocument/documentHighlight" then
    local group = vim.api.nvim_create_augroup("lsp_document_highlight", {})
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = buffer,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = group,
      buffer = buffer,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
