local installPath = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(installPath)) > 0 then
	packerBootstrap = vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", installPath })
end

local plugins = function(use)
	use "wbthomason/packer.nvim"

	-- ast
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
	use "nvim-treesitter/nvim-treesitter-textobjects"
	use "neovim/nvim-lspconfig"
	use { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lua", }

	-- text
	use "rosshadden/in-motion.nvim"
	use "hrsh7th/vim-vsnip"
	use "numToStr/Comment.nvim"

	-- navigation
	use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
	use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
	use "phaazon/hop.nvim"
	use "bendk/polyword.vim"

	-- enhancement
	use "ryvnf/readline.vim"

	-- integration
	use { "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }
	use "alexghergh/nvim-tmux-navigation"
	use "is0n/fm-nvim"

	-- misc
	use "echasnovski/mini.nvim"

	-- ui
	use "RRethy/nvim-base16"
	use "kyazdani42/nvim-web-devicons"

	-- languages
	use { "LhKipp/nvim-nu", run = ":TSInstall nu" }

	-- bootstrap new installations
	if packerBootstrap then require("packer").sync() end
end

require("packer").startup(plugins)

vim.cmd [[
	augroup packer
		autocmd!
		autocmd BufWritePost packages.lua source <afile> | PackerSync
	augroup end
]]
