local M = {}

function M.get_keymaps()
	-- stylua: ignore start
	return {
		{ "J",          '<cmd>Lspsaga peek_definition<CR>',       desc = "definition" },
		{ "K",          '<cmd>Lspsaga hover_doc<CR>',             desc = "document" },
		{ "gr",         '<cmd>Lspsaga rename<CR>',                desc = "rename" },
		{ "gl",         '<cmd>Lspsaga show_line_diagnostics<CR>', desc = "diagnostics" },
		{ "gh",         '<cmd>Lspsaga finder ref<CR>',            desc = "references" },
		{ "<leader>ca", '<cmd>Lspsaga code_action<CR>',           mode = { "n", "v" },   desc = "codeAction" },
		{ "[e",         '<cmd>Lspsaga diagnostic_jump_prev<CR>',  desc = "jumpprev" },
		{ "]e",         '<cmd>Lspsaga diagnostic_jump_next<CR>',  desc = "jumpnext" },
		{ "<leader>bf", M.format,                                 desc = "Format",       has = "documentFormatting" },
		{ "<leader>bf", M.format,                                 desc = "Format Range", mode = "v", has =	"documentRangeFormatting" },
	}
  -- stylua: ignore end
end

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
  local Keys = require "lazy.core.handler.keys"
  local keymaps = {}

  for _, value in ipairs(M.get_keymaps()) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = true
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
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

  -- inlay hint
  if client.server_capabilities.inlayHintProvider then vim.lsp.inlay_hint(buffer, true) end
end

return M
