local packer = require("packer")

local installPath = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(installPath)) > 0 then
	packerBootstrap = vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", installPath })
end

local plugins = function(use)
	use "wbthomason/packer.nvim"
	use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
	use "neovim/nvim-lspconfig"
	use { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", }
	use "hrsh7th/vim-vsnip"
	use "alexghergh/nvim-tmux-navigation"

	-- bootstrap if new clone
	if packerBootstrap then packer.sync() end
end

packer.startup(plugins)

vim.cmd([[
	augroup packer
		autocmd!
		autocmd BufWritePost packages.lua source <afile> | PackerCompile
	augroup end
]])
