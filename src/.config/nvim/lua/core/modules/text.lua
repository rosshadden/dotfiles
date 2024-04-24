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
require("mini.align").setup()
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

local constant = function(elements, options)
	options = options or {}
	options.elements = elements
	if options.preserve_case == nil then options.preserve_case = true end
	return augend.constant.new(options)
end

require("dial.config").augends:register_group {
	default = {
		augend.case.new { types = { "camelCase", "snake_case" } },
		augend.case.new { types = { "kebab-case", "snake_case" } },
		augend.constant.alias.bool,
		augend.date.alias["%H:%M"],
		augend.date.alias["%Y-%m-%d"],
		augend.date.alias["%Y/%m/%d"],
		augend.date.alias["%m/%d"],
		augend.date.alias["%m/%d/%Y"],
		augend.integer.alias.binary,
		augend.integer.alias.decimal_int,
		augend.integer.alias.hex,
		augend.integer.alias.octal,
		augend.semver.alias.semver,
		constant({ "&&", "||" }, { word = false }),
		constant({ "and", "or" }),
		constant({ "before", "after" }, { word = false }),
		constant({ "high", "low" }),
		constant({ "mon", "tues", "wed", "thurs", "fri", "sat", "sun" }),
		constant({ "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" }, { word = false }),
		constant({ "on", "off" }),
		constant({ "start", "stop" }),
		constant({ "yes", "no" }),
	},
}
