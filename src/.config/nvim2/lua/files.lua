local files = Mode.new("files", "<space>f")

pack("lmburns/lf.nvim", { "akinsho/toggleterm.nvim" })

local lf = require("lf")
local mini_pick = require("mini.pick")

--
-- SETTINGS
--

vim.g.lf_netrw = true

--
-- SETUP
--

mini_pick.setup({
	mappings = {
		choose_in_split = "<a-j>",
		choose_in_vsplit = "<a-l>",
		choose_in_tabpage = "<a-t>",
	},
})

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

--
-- MAPPINGS
--

files:map("c", function()
	mini_pick.builtin.files()
end)

files:map("<space>", lf.start)
