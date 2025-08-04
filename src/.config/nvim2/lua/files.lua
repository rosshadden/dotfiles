require("mini.pick").setup()

--
-- lf
--

vim.g.lf_netrw = true

pack("lmburns/lf.nvim", { "akinsho/toggleterm.nvim" })

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
