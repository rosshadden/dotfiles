local hyper = {
	"cmd",
	"alt",
	"ctrl",
}

local log = hs.logger.new("foo", "debug")

local home = function(cmd) return "/Users/ross/bin/" .. cmd end
local brew = function(cmd) return "/opt/homebrew/bin/" .. cmd end

local yabai = function(msg, text)
	local cmd = brew "yabai -m " .. msg
	if text then return cmd end
	hs.execute(cmd)
end

-- hs.ipc.cliInstall()
-- hs.loadSpoon("EmmyLua")

--
-- spaces
--

hs.hotkey.bind(hyper, "p", function()
	hs.execute(yabai("space --focus prev", true) .. " || " .. yabai("space --focus last", true))
end)

hs.hotkey.bind(hyper, "n", function()
	hs.execute(yabai("space --focus next", true) .. " || " .. yabai("space --focus first", true))
end)

-- TODO: ???
hs.hotkey.bind(hyper, "tab", function()
	yabai("window --focus recent")
end)

-- TODO: ???
for i = 1, 10, 1 do
	hs.hotkey.bind(hyper, i, function()
		yabai("space --focus " .. i)
	end)
end

--
-- windows
--

-- cardinal
hs.hotkey.bind(hyper, "h", function() yabai("window --focus west") end)
hs.hotkey.bind(hyper, "l", function() yabai("window --focus east") end)
hs.hotkey.bind(hyper, "j", function() yabai("window --focus south") end)
hs.hotkey.bind(hyper, "k", function() yabai("window --focus north") end)

hs.hotkey.bind(hyper, "b", function()
	yabai("window --focus prev")
end)

hs.hotkey.bind(hyper, "f", function()
	yabai("window --focus next")
end)

--
-- apps
--

hs.hotkey.bind(hyper, "return", function()
	-- hs.execute(home "wez")
	-- hs.execute(brew "wezterm cli spawn --new-window zsh")
	hs.execute(brew "wezterm start")
end)

--
-- meta
--

hs.hotkey.bind(hyper, "r", function()
	hs.reload()
end)
local reloadConfig = function(files)
	local doReload = false
	for _,file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

local watcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.alert.show("config loaded")
