local ui = Module.new("ui", "<space>u")

pack("https://github.com/folke/snacks.nvim")

local mini_base16 = require "mini.base16"
local mini_clue = require "mini.clue"
local mini_hipatterns = require "mini.hipatterns"
local mini_hiwords = require "mini.extra".gen_highlighter.words

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
-- SETUP
--

require "mini.cursorword".setup()
require "mini.icons".setup()

-- colorscheme

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

-- highlights

-- search
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#009f5b", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "CurSearch", { bg = "#009f5b", fg = "#ffffff" })

mini_hipatterns.setup({
	highlighters = {
		hex_color = mini_hipatterns.gen_highlighter.hex_color(),

		hack = mini_hiwords({ "HACK" }, "MiniHipatternsHack"),
		note = mini_hiwords({ "NOTE" }, "MiniHipatternsNote"),
		temp = mini_hiwords({ "TEMP" }, "MiniHipatternsFixme"),
		fix =  mini_hiwords({ "FIX" }, "MiniHipatternsFixme"),
		todo = mini_hiwords({ "TODO" }, "MiniHipatternsTodo"),
	},
})

-- clues
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
-- TODO: lol

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

require "snacks".setup({
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
-- EVENTS
--

-- automatically resize windows
vim.api.nvim_create_autocmd("VimResized", {
	group = ui.group,
	callback = function()
		vim.cmd("wincmd =")
	end,
})

vim.api.nvim_create_autocmd("User", {
	group = ui.group,
	pattern = "SnacksDashboardOpened",
	callback = function(args)
		vim.b[args.buf].minitrailspace_disable = true
	end,
})
