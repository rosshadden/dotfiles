local augend = require "dial.augend"
local dial = require "dial.map"
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

-- increment/decrement
vim.keymap.set("n", "<C-a>", dial.inc_normal(), { noremap = true })
vim.keymap.set("n", "<C-x>", dial.dec_normal(), { noremap = true })

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

require("dial.config").augends:register_group {
	default = {
		augend.integer.alias.decimal_int,
		augend.integer.alias.hex,
		augend.date.alias["%Y/%m/%d"],
		augend.date.alias["%Y-%m-%d"],
		augend.date.alias["%m/%d"],
		augend.date.alias["%H:%M"],

		augend.constant.alias.bool,
		augend.date.alias["%m/%d/%Y"],
		augend.semver.alias.semver,

    augend.constant.new {
			elements = { "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun" },
		},
		augend.constant.new {
			elements = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
		},
    augend.constant.new {
			elements = { "yes", "no" },
		},
    augend.constant.new {
			elements = { "on", "off" },
		},
    augend.constant.new {
			elements = { "start", "stop" },
		},
    augend.constant.new {
			elements = { "high", "low" },
		},
	},
}
