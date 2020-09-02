super = hs.hotkey.modal.new({}, "F18")
local hyper = {
	"cmd",
	"alt",
	"ctrl",
}

local append = function(tab, value)
	tab.insert(value)
	return tab
end

setmetatable(hyper, {
	__call = function(self, value)
		table.insert(self, value)
		return self[#self]
	end
})


fPressed = function()
	super.triggered = false
	super:enter()
end

fReleased = function()
	super:exit()
	if not super.triggered then
		hs.alert.show("tap")
	end
end

f = hs.hotkey.bind({}, "F18", fPressed, fReleased)

hs.hotkey.bind(hyper, "r", function()
	hs.reload()
	hs.alert.show("config reloaded")
end)

hs.hotkey.bind(hyper, "n", function()
	hs.alert.show(hyper[#hyper])
end)

hs.hotkey.bind(hyper, "h", function()
	hs.alert.show(hyper("shift"))
	hs.alert.show("Hi, Mom!")
end)

hs.hotkey.bind({ table.unpack(hyper), "shift" }, "h", function()
	hs.alert.show("HI, MOM!")
end)

hs.hotkey.bind(hyper, "w", function()
	hs.alert.show("w")
end)

-- super:bind({}, "h", function()
-- 	hs.alert.show("Hi, Mom!")
-- end)

-- hs.hotkey.bind({ "f18" }, "r", function()
-- 	hs.reload()
-- end)

-- hs.hotkey.bind({ "f18" }, "h", function()
-- 	hs.alert.show("Hi, Mom!")
-- end)
