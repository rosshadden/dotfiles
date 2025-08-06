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
files:map("c", function() mini_pick.registry.files({ tool = "fd" }) end)
files:map("C", function()
	mini_pick.registry.cli({
		command = { "fd", "--hidden", "--type", "f" },
	})
end)

-- git
files:map("g", mini_pick.registry.git_files)

-- open explorer at file's cwd
files:map("<space>", lf.start)
-- open explorer at git root dir
-- FIX: makes future `lf.start()`s start in gwd too for some reason
files:map("<a-space>", function()
	lf.start({ dir = "gwd" })
end)

-- search
files:map("s", mini_pick.registry.grep_live)
files:map("S", mini_pick.registry.grep)
