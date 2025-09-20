local obsidian = Module.new("obsidian")

pack("obsidian-nvim/obsidian.nvim", {
	"MeanderingProgrammer/render-markdown.nvim",
	{ src = "nvim-treesitter/nvim-treesitter", version = "main" },
})

pack "oflisback/obsidian-bridge.nvim"

require("render-markdown").setup({
	completions = { lsp = { enabled = true } },

	render_modes = true,

	heading = {
		border = true,
	},

	code = {
		border = "thick",
	},
})

require("obsidian").setup({
	legacy_commands = false,

	workspaces = {
		{
			name = "main",
			path = "~/notes/main",
		},
		{
			name = "cuda",
			path = "~/notes/cuda",
		},
	},

	ui = { enable = false },
})

require("obsidian-bridge").setup()
