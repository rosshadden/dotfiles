local polyword = require "polyword"
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
vim.keymap.set("", "<space>p", "<plug><put-in-motion>", { silent = true })
vim.keymap.set("", "<space>s", "<plug><sort-in-motion>", { silent = true })
vim.keymap.set("n", "<space>S", "<plug><surround>", { silent = true })
vim.keymap.set("n", "<space>m", "<plug><polyword>", { silent = true })

-- miniword
vim.keymap.set("", "<plug><polyword>w", function() polyword.miniword("w") end, { silent = true })
vim.keymap.set("", "<plug><polyword>b", function() polyword.miniword("b") end, { silent = true })
vim.keymap.set("", "<plug><polyword>e", function() polyword.miniword("e") end, { silent = true })
vim.keymap.set("", "<plug><polyword>ge", function() polyword.miniword("ge") end, { silent = true })
vim.keymap.set("o", "im", function() polyword.miniword("iw") end, { silent = true })
vim.keymap.set("o", "am", function() polyword.miniword("aw") end, { silent = true })

-- megaword
vim.keymap.set("", "<plug><polyword>W", function() polyword.megaword("w") end, { silent = true })
vim.keymap.set("", "<plug><polyword>B", function() polyword.megaword("b") end, { silent = true })
vim.keymap.set("", "<plug><polyword>E", function() polyword.megaword("e") end, { silent = true })
vim.keymap.set("", "<plug><polyword>gE", function() polyword.megaword("ge") end, { silent = true })
vim.keymap.set("o", "iM", function() polyword.megaword("iw") end, { silent = true })
vim.keymap.set("o", "aM", function() polyword.megaword("aw") end, { silent = true })

-- transform
vim.keymap.set("", "<plug><polyword>c", function() polyword.transform("camel") end, { silent = true })
vim.keymap.set("", "<plug><polyword>C", function() polyword.transform("pascal") end, { silent = true })
vim.keymap.set("", "<plug><polyword>s", function() polyword.transform("snake") end, { silent = true })
vim.keymap.set("", "<plug><polyword>S", function() polyword.transform("snake-upper") end, { silent = true })
vim.keymap.set("", "<plug><polyword>k", function() polyword.transform("kebab") end, { silent = true })
vim.keymap.set("", "<plug><polyword>K", function() polyword.transform("kebab-upper") end, { silent = true })

--
-- SETUP
--

inMotion.put.setup()
inMotion.sort.setup()

require("Comment").setup()

-- require("mini.pairs").setup()

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
