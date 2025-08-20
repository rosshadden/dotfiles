--- @type vim.lsp.Config
local result = {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = {
						"E111",
						"E501",
					},
				},
			},
		},
	},
}
return result
