local debug = Module.new("debug", "<space>d")

local mini_pick = require "mini.pick"

debug:map("<space>", function()
	vim.print(mini_pick.registry)
end)
