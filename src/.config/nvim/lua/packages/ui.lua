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

return {
	"nvim-tree/nvim-web-devicons",

	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			dashboard = {
				preset = {
					header = header,
					foo = "bar",
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
						padding = 1
					}),
					section("recent_files", {
						icon = " ",
						title = "Recent Files",
						indent = 2,
						padding = 1,
						pane = 2
					}),
					section("terminal", {
						icon = " ",
						title = "Git Status",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch",
						padding = 1,
						ttl = 5 * 32,
						indent = 4,
						pane = 2,
					}),
					section("startup", {
						indent = 32,
						padding = 1
					}),
					section({
						align = 'center',
						text = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch,
						padding = 1,
						indent = 32
					}),
				},
			},
		},
	},
}
