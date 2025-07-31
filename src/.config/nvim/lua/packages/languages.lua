return {
	-- universal
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "master",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "master",
	},
	"neovim/nvim-lspconfig",

	-- individual
	{ "mrcjkb/rustaceanvim", version = '^5', lazy = false, },
	{ "aklt/plantuml-syntax", { "weirongxu/plantuml-previewer.vim", dependencies = "tyru/open-browser.vim" } },
	{ "nushell/tree-sitter-nu" },
	{ "kmonad/kmonad-vim", ft = "kbd" },
	{ "alaviss/nim.nvim", ft = "nim" },
}
