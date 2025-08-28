local sync = Module.new("sync", "<space>s")

pack "lewis6991/gitsigns.nvim"

--
-- SETUP
--

require("mini.diff").setup()
require("mini.git").setup()

--
-- MAPPINGS
--

local tigs = utils.Term:new({
	cmd = "tig status",
	persist_mode = true,
})

sync:map("<space>", function()
	tigs:toggle "float"
end)

sync:map("t", function()
	tigs:toggle "tab"
end)

sync:map("w", function()
	tigs:toggle "window"
end)

sync:map("h", function()
	tigs:toggle "left"
end)

sync:map("l", function()
	tigs:toggle "right"
end)

sync:map("j", function()
	tigs:toggle "below"
end)

sync:map("k", function()
	tigs:toggle "above"
end)
