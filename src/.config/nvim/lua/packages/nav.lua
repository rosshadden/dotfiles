return {
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" } },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"smoka7/hop.nvim",
	"chrisgrieser/nvim-spider",
	{
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			require("various-textobjs").setup({ keymaps = { useDefaults = true } })
		end,
	},
}
