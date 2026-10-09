local M = {}

function M.on_attach(client, buffer)
	vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"
	-- Common LSP keymaps
	local keymaps = {
		{ "K",          vim.lsp.buf.hover,                  method = "hover" },
		{ "gd",         "<CMD>Glance definitions<CR>",      method = "definition" },
		{ "gt",         "<CMD>Glance type_definitions<CR>", method = "typeDefinition" },
		{ "gh",         "<CMD>Glance references<CR>",       method = "references" },
		{ "gi",         "<CMD>Glance implementations<CR>",  method = "implementation" },
		{ "gr",         ":IncRename ",                      method = "rename" },
		{ "gD",         vim.lsp.buf.declaration,            method = "declaration" },
		{ "<C-k>",      vim.lsp.buf.signature_help,         method = "signatureHelp" },
		{ "]d",         vim.diagnostic.goto_next,           desc = "Next Diagnostic", method = "diagnostic" },
		{ "[d",         vim.diagnostic.goto_prev,           desc = "Prev Diagnostic", method = "diagnostic" },
		{ "<leader>ca", vim.lsp.buf.code_action,            mode = { "n", "v" },      method = "codeAction" },
	}

	for _, keys in ipairs(keymaps) do
		if client:supports_method("textDocument/" .. keys.method) then
			vim.keymap.set(keys.mode or "n", keys[1], keys[2], { buffer = buffer, desc = keys.method })
		end
	end

	-- highlight hint
	if client:supports_method "textDocument/documentHighlight" then
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
