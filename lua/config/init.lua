local M = {}

local options = {
	-- icons used by other plugins
	icons = {
		cmp_kinds = {
			Array = ' ',
			Boolean = ' ',
			Class = ' ',
			Color = ' ',
			Constant = ' ',
			Constructor = ' ',
			Copilot = ' ',
			Enum = ' ',
			EnumMember = ' ',
			Event = ' ',
			Field = ' ',
			File = ' ',
			Folder = ' ',
			Function = ' ',
			Interface = ' ',
			Key = ' ',
			Keyword = ' ',
			Method = ' ',
			Module = ' ',
			Namespace = ' ',
			Null = ' ',
			Number = ' ',
			Object = ' ',
			Operator = ' ',
			Package = ' ',
			Property = ' ',
			Reference = ' ',
			Snippet = ' ',
			String = ' ',
			Struct = ' ',
			Text = '',
			TypeParameter = ' ',
			Unit = ' ',
			Value = ' ',
			Variable = ' ',
		},
		diagnostics = {
			Error = '😱',
			Warn = '⚠',
			Hint = '🔰',
			Info = '👀',
		},
		git = {
			added = ' ',
			modified = ' ',
			removed = ' ',
		},
	},
	-- exclude from indent lines
	ft_exclude = {
		'aerial',
		'chatgpt',
		'checkhealth',
		'conf',
		'crunner',
		'dashboard',
		'dap-repl',
		'help',
		'lazy',
		'lspinfo',
		'man',
		'markdown',
		'mason',
		'neo-tree',
		'norg',
		'notify',
		'qf',
		'query',
	},
}

setmetatable(M, {
	__index = function(_, key)
		return options[key]
	end,
})

return M
