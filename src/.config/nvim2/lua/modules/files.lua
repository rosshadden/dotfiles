local files = Module.new("files", "<space>f")

pack("lmburns/lf.nvim", { "akinsho/toggleterm.nvim" })

local lf = require "lf"
local mini_pick = require "mini.pick"

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

-- choose
files:map("c", function() mini_pick.builtin.files({ tool = "fd" }) end)
files:map("C", function()
	mini_pick.builtin.cli({
		command = { "fd", "--hidden", "--type", "f" },
	})
end)

-- git
files:map("g", function() mini_pick.builtin.files({ tool = "git" }) end)

-- open explorer at file's cwd
files:map("<space>", lf.start)
-- open explorer at git root dir
-- FIX: makes future `lf.start()`s start in gwd too for some reason
files:map("<a-space>", function()
	lf.start({ dir = "gwd" })
end)
