local ui = Module.new("ui")
local folds = Module.new("folds", "<space>z")

pack("https://github.com/folke/snacks.nvim")

--
-- SETTINGS
--

-- folds
vim.opt.foldenable = false

-- concealment
vim.opt.conceallevel = 2

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

require("mini.cursorword").setup()

-- clues
local mini_clue = require "mini.clue"
mini_clue.setup({
	triggers = {
		-- completions
		{ mode = "i", keys = "<c-x>" },

		-- goto
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		-- registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<c-r>" },
		{ mode = "c", keys = "<c-r>" },

		-- windows
		{ mode = "n", keys = "<c-w>" },

		-- folds
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
	},

	clues = {
		mini_clue.gen_clues.builtin_completion(),
		mini_clue.gen_clues.g(),
		mini_clue.gen_clues.marks(),
		mini_clue.gen_clues.registers(),
		mini_clue.gen_clues.windows(),
		mini_clue.gen_clues.z(),
	},
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
-- MAPPINGS
--

-- folds

-- toggle folds
folds:map("<space>", "za")

-- create fold
folds:map("c", "zf")

-- fold levels
folds:map("[", cmd "set foldlevel=0")
folds:map("0", cmd "set foldlevel=128")
for i = 1, 9, 1 do
	folds:map(i, cmd "set foldlevel=" .. i)
end

--
-- EVENTS
--

-- automatically resize windows
vim.api.nvim_create_autocmd("VimResized", {
	group = ui.group,
	callback = function()
		vim.cmd("wincmd =")
	end,
})
