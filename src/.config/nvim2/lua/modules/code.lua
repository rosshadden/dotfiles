local code = Module.new("code")

pack("monaqa/dial.nvim")

local augend = require "dial.augend"
local dial = require "dial.map"

--
-- SETTINGS
--

-- indents
vim.opt.shiftwidth = 0
vim.opt.tabstop = 2

-- spelling
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- meta
vim.opt.swapfile = false

--
-- FUCTIONS
--

local constant = function(elements, options)
	options = options or {}
	options.elements = elements
	if options.preserve_case == nil then options.preserve_case = true end
	return augend.constant.new(options)
end

--
-- SETUP
--

require "mini.align".setup()
require "mini.splitjoin".setup()
require "mini.surround".setup()

require "mini.move".setup({
	mappings = {
		down = "<down>",
		left = "<left>",
		right = "<right>",
		up = "<up>",

		line_down = "<down>",
		line_left = "<left>",
		line_right = "<right>",
		line_up = "<up>",
	}
})

require("dial.config").augends:register_group({
	default = {
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
		constant({ "True", "False" }),
		constant({ "and", "or" }),
		constant({ "before", "after" }, { word = false }),
		constant({ "high", "low" }),
		constant({ "mon", "tues", "wed", "thurs", "fri", "sat", "sun" }),
		constant({ "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" }, { word = false }),
		constant({ "on", "off" }),
		constant({ "start", "stop" }),
		constant({ "up", "down", "left", "right" }),
		constant({ "yes", "no" }),
	},
})

--
-- MAPPINGS
--

-- enhancements

-- delete word
map("<c-backspace>", "<c-w>", "i")

-- redo
map("U", "<c-r>")
-- find
map("<leader>/", [[/\v]], "", { silent = false })

-- increment/decrement
map("<c-a>", dial.inc_normal())
map("<c-x>", dial.dec_normal())

--
-- EVENTS
--

-- preserve cursor position [:h restore-cursor]
vim.api.nvim_create_autocmd("BufRead", {
	group = code.group,
	command = [[
		if line("'\"") > 1 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
	]],
})
