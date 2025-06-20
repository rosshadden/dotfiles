--
-- SETTINGS
--

-- line numbers
vim.opt.number = true

-- status
vim.opt.laststatus = 3
vim.opt.winbar = "%=%m %f"

-- concealment
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nv"

-- colorscheme
vim.opt.termguicolors = true

-- startup menu
local mini_starter = require "mini.starter"
mini_starter.setup({
	items = {
		mini_starter.sections.builtin_actions(),
		mini_starter.sections.recent_files(10, true),
		mini_starter.sections.pick(),
		mini_starter.sections.sessions(),
		mini_starter.sections.telescope(),
	},
})

--
-- SETUP
--

-- colorscheme

local mini_base16 = require("mini.base16")
mini_base16.setup({
	-- palette = mini_base16.mini_palette("#2b1a33", "#c9c5cb", 100),
	palette = {
		-- base00 = "#2b1a33",
		-- base01 = "#41323f",
		-- base02 = "#4f424c",
		-- base03 = "#776e71",
		-- base04 = "#8d8687",
		-- base05 = "#ff6666",
		-- base06 = "#b9b6b0",
		-- base07 = "#e7e9db",
		-- base08 = "#ef6155",
		-- base09 = "#f99b15",
		-- base0A = "#fec418",
		-- base0B = "#48b685",
		-- base0C = "#5bc4bf",
		-- base0D = "#06b6ef",
		-- base0E = "#815ba4",
		-- base0F = "#e96ba8",

		base00 = "#100323",
		base01 = "#271C3A",
		base02 = "#3E2D5C",
		base03 = "#5D5766",
		base04 = "#BEBCBF",
		base05 = "#DEDCDF",
		base06 = "#EDEAEF",
		base07 = "#BBAADD",
		base08 = "#A92258",
		base09 = "#918889",
		base0A = "#804ead",
		base0B = "#C6914B",
		base0C = "#7263AA",
		base0D = "#8E7DC6",
		base0E = "#953B9D",
		base0F = "#e96ba8",
	},
	use_cterm = true,
})

-- require("mini.hues").setup({
-- 	background = "#2b1a33",
-- 	foreground = "#c9c5cb",
-- 	accent = "fg",
-- 	saturation = "high",
-- 	nrhues = 100,
-- })

vim.cmd [[
	" transparency
	" highlight Normal guibg=none
	" highlight NormalNC guibg=none
	" highlight NormalFloat guibg=none
	" highlight LineNr guibg=none
	" highlight SignColumn guibg=none

	" search
	highlight Search guibg=#41323f guifg=#fec418
	highlight IncSearch guibg=#41323f guifg=#ef6155
]]

-- animations
require("mini.animate").setup({
	close = { enable = false },
	open = { enable = false },
	resize = { enable = false },
	scroll = { enable = false },
})

-- highlights
local mini_hipatterns = require("mini.hipatterns")
mini_hipatterns.setup({
	highlighters = {
		hex_color = mini_hipatterns.gen_highlighter.hex_color(),

		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		temp = { pattern = "%f[%w]()TEMP()%f[%W]", group = "MiniHipatternsFixme" },
		fix =  { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
	},
})

-- clues
local mini_clue = require("mini.clue")
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
