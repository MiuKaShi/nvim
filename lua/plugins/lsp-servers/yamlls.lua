local M = {}

M.setup = function(on_attach, capabilities)
	require("lspconfig").yamlls.setup {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			yaml = {
				schemas = {
					["https://cfn-schema.y13i.com/schema?region=eu-west-2&version=20.0.0"] = "cloudformation/*",
					["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
				},
				format = { enable = false },
				completion = true,
				hover = true,
				customTags = {
					"!And scalar",
					"!And mapping",
					"!And sequence",
					"!Condition scalar",
					"!Condition mapping",
					"!Condition sequence",
					"!Base64 scalar",
					"!Base64 mapping",
					"!Base64 sequence",
					"!If scalar",
					"!If mapping",
					"!If sequence",
					"!Not scalar",
					"!Not mapping",
					"!Not sequence",
					"!Equals scalar",
					"!Equals mapping",
					"!Equals sequence",
					"!Or scalar",
					"!Or mapping",
					"!Or sequence",
					"!FindInMap scalar",
					"!FindInMap mappping",
					"!FindInMap sequence",
					"!Base64 scalar",
					"!Base64 mapping",
					"!Base64 sequence",
					"!Cidr scalar",
					"!Cidr mapping",
					"!Cidr sequence",
					"!Ref scalar",
					"!Ref mapping",
					"!Ref sequence",
					"!Sub scalar",
					"!Sub mapping",
					"!Sub sequence",
					"!GetAtt scalar",
					"!GetAtt mapping",
					"!GetAtt sequence",
					"!GetAZs scalar",
					"!GetAZs mapping",
					"!GetAZs sequence",
					"!ImportValue scalar",
					"!ImportValue mapping",
					"!ImportValue sequence",
					"!Select scalar",
					"!Select mapping",
					"!Select sequence",
					"!Split scalar",
					"!Split mapping",
					"!Split sequence",
					"!Join scalar",
					"!Join mapping",
					"!Join sequence",
				},
			},
		},
	}
end

return M