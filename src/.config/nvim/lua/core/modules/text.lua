local inMotion = require "in-motion"

--
-- SETTINGS
--

-- spelling
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- disable word wrap
vim.opt.wrap = false

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>S", "<plug><surround>", { silent = true })

vim.keymap.set("n", "S", "s$", { silent = true, remap = true })

--
-- SETUP
--

inMotion.put.setup()
inMotion.sort.setup()

require("Comment").setup()

require("mini.ai").setup()
require("mini.cursorword").setup()
-- require("mini.pairs").setup()
require("mini.trailspace").setup()

require("mini.surround").setup {
	mappings = {
		add = "s",
		delete = "ds",
		replace = "cs",
		find = "<plug><surround>l",
		find_left = "<plug><surround>h",
		highlight = "<plug><surround><space>",
		update_n_lines = "<plug><surround>c",
	}
}
