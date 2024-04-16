local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = function()
	return {
		-- lib
		{
			"vhyrro/luarocks.nvim",
			priority = 1000,
			config = true,
		},

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
			"onsails/lspkind.nvim",
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
		{
			"zbirenbaum/copilot.lua",
			config = function()
				require("copilot").setup({
					suggestion = { enabled = false },
					panel = { enabled = false },
				})
			end
		},
		{
			"zbirenbaum/copilot-cmp",
			config = function ()
				require("copilot_cmp").setup()
			end
		},
		{
			"Exafunction/codeium.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"hrsh7th/nvim-cmp",
			},
			config = function()
				require("codeium").setup()
			end
		},
		{
			"NeogitOrg/neogit",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"sindrets/diffview.nvim",
			},
			config = true
		},
		{ "lewis6991/gitsigns.nvim", dependencies = "nvim-lua/plenary.nvim" },
		"alexghergh/nvim-tmux-navigation",
		"is0n/fm-nvim",
		"gpanders/editorconfig.nvim",
		{
			"jackMort/ChatGPT.nvim",
			event = "VeryLazy",
			config = function()
				require("chatgpt").setup()
			end,
			dependencies = {
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"folke/trouble.nvim",
			}
		},
		{
			"nvim-neorg/neorg",
			dependencies = { "luarocks.nvim" },
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
