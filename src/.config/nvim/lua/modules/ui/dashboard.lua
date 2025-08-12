pack "https://github.com/folke/snacks.nvim"

--
-- FUNCTIONS
--

--- Creates a dashboard section config.
---
--- - `section("name")` → `{ section = "name" }`
--- - `section({ ... })` → `{ ... }`
--- - `section(fn)` → `fn`
--- - `section("name", { ... })` → `{ section = "name", ... }`
---
--- @param a string|table Section name or config table.
--- @param b? table Optional config table.
--- @return table Normalized section config.
local section = function(a, b)
	if b ~= nil then
		b.section = a
		return b
	end
	if type(a) == "string" then
		return { section = a }
	end
	return a
end

--
-- SETUP
--

local version = vim.version()
local header = [[
  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
 ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██
 ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
 ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
 ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░
          ░    ░  ░    ░ ░        ░   ░         ░
                                 ░
]]

local snacks = require "snacks"

snacks.setup({
	dashboard = {
		preset = {
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
				{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
			header = header,
		},
		sections = {
			section("header"),
			section("terminal", {
				pane = 2,
				cmd = "chafa --probe off --stretch ~/Pictures/ermak.png",
				padding = 1,
			}),
			section("keys", {
				gap = 1,
				padding = 1,
			}),
			section("recent_files", {
				icon = " ",
				title = "Recent Files",
				limit = 16,
				cwd = true,
				indent = 2,
				padding = 1,
				pane = 2,
			}),
			section("terminal", {
				icon = " ",
				title = "Git Status",
				enabled = function()
					return snacks.git.get_root() ~= nil
				end,
				cmd = "git status --short --branch",
				padding = 1,
				ttl = 5 * 32,
				indent = 4,
				pane = 2,
			}),
			-- section("startup", {
			-- 	indent = 32,
			-- 	padding = 1
			-- }),
			section({
				align = 'center',
				text = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch,
				padding = 1,
				indent = 32,
			}),
		},
	},
})
