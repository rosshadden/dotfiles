local app = Module.new("app", "<space>a")

pack "folke/persistence.nvim"

local mini_pick = require "mini.pick"

--
-- SETUP
--

require("mini.bracketed").setup()
require("mini.extra").setup()
require("persistence").setup()

require("mini.basics").setup({
	extra_ui = true,
})

mini_pick.setup({
	mappings = {
		choose_in_split = "<a-j>",
		choose_in_vsplit = "<a-l>",
		choose_in_tabpage = "<a-t>",
	},
})

mini_pick.registry.registry = function()
	local items = vim.tbl_keys(mini_pick.registry)
	table.sort(items)
	local source = { items = items, name = 'Registry', choose = function() end }
	local chosen_picker_name = mini_pick.start({ source = source })
	if chosen_picker_name == nil then return end
	return mini_pick.registry[chosen_picker_name]()
end

--
-- FUNCTIONS
--

--- Reload config.
--- FIX: not working
local function reload()
	for name, _ in pairs(package.loaded) do
		if name:match "^core" then
			package.loaded[name] = nil
		end
	end
	dofile(vim.env.MYVIMRC)
	vim.api.nvim_echo({ { "config reloaded" } }, false, {})
end

--
-- MAPPINGS
--

-- quit
app:map("q", cmd "quitall")
app:map("Q", cmd "quitall!")

-- error
app:map("e", cmd "cquit")
app:map("E", cmd "cquit!")

-- write
app:map("w", cmd "wall")
app:map("W", cmd "wall!")

-- exit
app:map("x", cmd "xall")
app:map("X", cmd "xall!")

-- close
app:map("c", cmd "bufdo bdelete")
app:map("C", cmd "bufdo bdelete!")

-- reload
app:map("r", reload)
app:map("R", cmd "restart")

-- messages
app:map("m", cmd "messages")
app:map("M", cmd "messages clear")

-- picker
app:map(".", mini_pick.registry.resume)
app:map(":", mini_pick.registry.commands)
app:map("<space>", mini_pick.registry.registry)
app:map("h", mini_pick.registry.help)
app:map("k", mini_pick.registry.keymaps)
