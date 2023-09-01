local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = function()
	return {
		-- ast
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		"nvim-treesitter/nvim-treesitter-textobjects",
		"neovim/nvim-lspconfig",

		-- completion
		{
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
		},

		-- snippets
		{
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			-- { "L3MON4D3/LuaSnip" },
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"Metalymph/zig-snippets",
		},

		-- text
		"rosshadden/in-motion.nvim",
		"numToStr/Comment.nvim",

		-- navigation
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" }
		},
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		-- "phaazon/hop.nvim",
		"spamwax/hop.nvim",
		"bendk/polyword.vim",

		-- enhancement
		"ryvnf/readline.vim",
		"lambdalisue/file-protocol.vim",
		"monaqa/dial.nvim",

		-- integration
		"Exafunction/codeium.vim",
		{ "lewis6991/gitsigns.nvim", dependencies = "nvim-lua/plenary.nvim" },
		"alexghergh/nvim-tmux-navigation",
		"is0n/fm-nvim",
		"gpanders/editorconfig.nvim",
		{
			"jackMort/ChatGPT.nvim",
			event = "VeryLazy",
			config = function()
				require("chatgpt").setup({
					api_key_cmd = "echo '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'",
				})
			end,
			dependencies = {
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim"
			}
		},
		{
			"nvim-neorg/neorg",
			dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter" },
			build = ":Neorg sync-parsers",
			config = function()
				require("core.plugins.neorg")
			end,
		},
		{ "eraserhd/parinfer-rust", build = "cargo build --release" },

		-- misc
		"echasnovski/mini.nvim",

		-- ui
		"RRethy/nvim-base16",
		"kyazdani42/nvim-web-devicons",

		-- languages
		{ "aklt/plantuml-syntax", { "weirongxu/plantuml-previewer.vim", dependencies = "tyru/open-browser.vim" } },
		{ "LhKipp/nvim-nu", ft = "nu", build = ":TSInstall nu" },
		{ "kmonad/kmonad-vim", ft = "kbd" },
		{ "alaviss/nim.nvim", ft = "nim" },
		{ { "SeniorMars/typst.nvim", ft = "typ" }, "kaarmu/typst.vim" },
	}
end

require("lazy").setup(plugins())
