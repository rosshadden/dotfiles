local norg = require("neorg")

norg.setup {
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {
			config = {
				icon_preset = "diamond",
			},
		},
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
				default_workspace = "notes",
			},
		},
		["core.export"] = {},
		["core.integrations.treesitter"] = {},
	},
}
