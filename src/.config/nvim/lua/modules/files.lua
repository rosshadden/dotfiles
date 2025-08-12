local files = Module.new("files", "<space>f")

pack("mikavilpas/yazi.nvim", { "nvim-lua/plenary.nvim" })

local yazi = require "yazi"
local mini_pick = require "mini.pick"

--
-- SETTINGS
--

vim.g.loaded_netrwPlugin = 1

--
-- SETUP
--

yazi.setup({
	open_for_directories = true,
	keymaps = {
		show_help = "<f2>",
		open_file_in_vertical_split = "<a-l>",
		open_file_in_horizontal_split = "<a-j>",
		open_file_in_tab = "<a-t>",
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
files:map("<space>", yazi.yazi)
-- open explorer at git root dir
files:map("<a-space>", call(yazi.yazi, nil, vim.fn.getcwd()))

-- search
files:map("s", mini_pick.registry.grep_live)
files:map("S", mini_pick.registry.grep)
