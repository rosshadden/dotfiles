local folds = Module.new("folds", "<space>z")
local ui = Module.new("ui")

--
-- SETTINGS
--

-- folds
vim.opt.foldenable = false

-- concealment
vim.opt.conceallevel = 2

-- scroll offset
vim.o.scrolloff = 8

--
-- SETUP
--

require("mini.cursorword").setup()
require("mini.notify").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()

-- clues
local mini_clue = require "mini.clue"
mini_clue.setup({
	triggers = {
		-- follow the leader
		{ mode = "n", keys = "<leader>" },
		{ mode = "x", keys = "<leader>" },

		-- `[` and `]` keys
		{ mode = 'n', keys = '[' },
		{ mode = 'n', keys = ']' },

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

		-- modes
		{ mode = "n", keys = "<space>" },
	},

	clues = {
		mini_clue.gen_clues.square_brackets(),
		mini_clue.gen_clues.builtin_completion(),
		mini_clue.gen_clues.g(),
		mini_clue.gen_clues.marks(),
		mini_clue.gen_clues.registers(),
		mini_clue.gen_clues.windows(),
		mini_clue.gen_clues.z(),

		-- modes
		{ mode = "n", keys = "<space>", desc = "+Modules" },
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
