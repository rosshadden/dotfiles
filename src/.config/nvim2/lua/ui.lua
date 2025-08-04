--
-- SETTINGS
--

-- status
vim.opt.laststatus = 3
vim.opt.winbar = "%=%m %f"

-- concealment
vim.opt.conceallevel = 2

-- dialogs
vim.opt.winborder = "rounded"

--
-- PACKAGES
--

require("mini.cursorword").setup()
require("mini.icons").setup()

-- colorscheme

local mini_base16 = require("mini.base16")
mini_base16.setup({
	palette = mini_base16.mini_palette("#2b1a33", "#c9c5cb", 100),
	-- palette = {
	-- 	base00 = "#100323",
	-- 	base01 = "#271C3A",
	-- 	base02 = "#3E2D5C",
	-- 	base03 = "#5D5766",
	-- 	base04 = "#BEBCBF",
	-- 	base05 = "#DEDCDF",
	-- 	base06 = "#EDEAEF",
	-- 	base07 = "#BBAADD",
	-- 	base08 = "#A92258",
	-- 	base09 = "#918889",
	-- 	base0A = "#804ead",
	-- 	base0B = "#C6914B",
	-- 	base0C = "#7263AA",
	-- 	base0D = "#8E7DC6",
	-- 	base0E = "#953B9D",
	-- 	base0F = "#e96ba8",
	-- },
	use_cterm = true,
})

-- dashboard

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

pack("https://github.com/folke/snacks.nvim")

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

require("snacks").setup({
	dashboard = {
		preset = {
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
				indent = 2,
				padding = 1,
				pane = 2,
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

--
-- FUNCTIONS
--

vim.api.nvim_create_autocmd("User", {
	pattern = "SnacksDashboardOpened",
	callback = function(args)
		vim.b[args.buf].minitrailspace_disable = true
	end,
})
