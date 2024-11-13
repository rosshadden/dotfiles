local norg = require("neorg")

norg.setup {
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {
			config = {
				icon_preset = "varied",
				-- lifted from https://www.reddit.com/r/neovim/comments/15liww4/comment/jvgml89/
				icons = {
					delimiter = {
						horizontal_line = {
							highlight = "@neorg.delimiters.horizontal_line",
						},
					},
					code_block = {
						content_only = true,
						width = "content",
						padding = {
							-- left = 20,
							-- right = 20,
						},
						conceal = true,
						nodes = { "ranged_verbatim_tag" },
						highlight = "CursorLine",
						-- render = module.public.icon_renderers.render_code_block,
						insert_enabled = true,
					},
				},
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

		["core.keybinds"] = {
			config = {
				hook = function(mappings)
					mappings.remap_key("norg", "n", "<C-Space>", "<localleader>t<space>")
				end,
			}
		},

		["core.integrations.treesitter"] = {},
	},
}
