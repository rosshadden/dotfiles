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
	layout = "float",
	cmd = "tig status",
})

sync:map("<space>", function()
	tigs:toggle()
end)
