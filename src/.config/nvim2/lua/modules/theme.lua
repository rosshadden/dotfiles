local theme = Module.new("theme")

--
-- SETTINGS
--

-- invisibles
local space = "·"
vim.opt.list = true
vim.opt.listchars = {
	extends = ">",
	lead = space,
	multispace = space,
	nbsp = "_",
	precedes = "<",
	tab = "│─",
	trail = space,
}

-- status
vim.opt.laststatus = 3
vim.opt.winbar = "%=%m %f"

-- dialogs
vim.opt.winborder = "rounded"

--
-- SETUP
--

require("mini.icons").setup()
require("mini.trailspace").setup()

-- colorscheme

local mini_base16 = require "mini.base16"
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

-- require("mini.hues").setup({
-- 	background = "#2b1a33",
-- 	foreground = "#c9c5cb",
-- 	accent = "fg",
-- 	saturation = "high",
-- 	nrhues = 100,
-- })

-- highlights

-- search
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#009f5b", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "CurSearch", { bg = "#009f5b", fg = "#ffffff" })

local mini_hipatterns = require "mini.hipatterns"
local mini_hiwords = require("mini.extra").gen_highlighter.words
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

--
-- EVENTS
--

vim.api.nvim_create_autocmd("User", {
	group = theme.group,
	pattern = "SnacksDashboardOpened",
	callback = function(args)
		vim.b[args.buf].minitrailspace_disable = true
	end,
})
