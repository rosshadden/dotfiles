local terminal = Module.new("terminal", "<space>T")

--
-- MAPPINGS
--

terminal:map("<space>", function()
	local term = utils.Term:new({
		layout = "float",
	})
	term:toggle()
end)

terminal:map("h", function()
	local term = utils.Term:new({
		layout = "left",
	})
	term:toggle()
end)

terminal:map("l", function()
	local term = utils.Term:new({
		layout = "right",
	})
	term:toggle()
end)

terminal:map("k", function()
	local term = utils.Term:new({
		layout = "above",
	})
	term:toggle()
end)

terminal:map("j", function()
	local term = utils.Term:new({
		layout = "below",
	})
	term:toggle()
end)
