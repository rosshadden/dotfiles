--
-- lf
--

local mini_pick = require("mini.pick")
mini_pick.setup({
	mappings = {
		choose_in_split = "<a-j>",
		choose_in_vsplit = "<a-l>",
		choose_in_tabpage = "<a-t>",
	},
})

map("<leader>f", function()
	mini_pick.builtin.files()
end)

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

map("<leader>b", lf.start)
