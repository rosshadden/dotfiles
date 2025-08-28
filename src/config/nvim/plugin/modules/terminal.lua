local terminal = Module.new("terminal", "<space>m")

--
-- MAPPINGS
--

terminal:map("<space>", function()
	utils.Term:new():focus("float")
end)

terminal:map("j", function()
	utils.Term:new():focus("below")
end)

terminal:map("k", function()
	utils.Term:new():focus("above")
end)

terminal:map("h", function()
	utils.Term:new():focus("left")
end)

terminal:map("l", function()
	utils.Term:new():focus("right")
end)

-- breakout.exe of terminal mode
map("<c-esc>", [[<c-\><c-n>]], "t")
