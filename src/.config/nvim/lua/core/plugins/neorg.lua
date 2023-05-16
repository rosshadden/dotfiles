local norg = require("neorg")

norg.setup {
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/dev/lit/notes",
				},
			},
		},
	},
}
