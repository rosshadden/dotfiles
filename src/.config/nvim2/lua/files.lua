--
-- lf
--

vim.g.lf_netrw = true

vim.pack.add({
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/lmburns/lf.nvim",
})

local lf = require("lf")
lf.setup({
	border = "rounded",
	default_actions = {
		["<a-l>"] = "vsplit",
		["<a-h>"] = "vsplit",
		["<a-j>"] = "split",
		["<a-k>"] = "split",
		["<a-t>"] = "tab drop",
	},
})

map("<leader>f", lf.start)
