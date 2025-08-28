local theme = Module.new("theme", "<space>H")

pack "scottmckendry/cyberdream.nvim"

local mini_base16 = require "mini.base16"

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

-- colors
require("cyberdream").setup({
	transparent = true,
	italic_comments = true,

	highlights = {
		Search = { link = "MiniHipatternsNote" },
		IncSearch = { link = "MiniHipatternsTodo" },
		CurSearch = { link = "IncSearch" },
		CursorLine = { bg = "#1e2124" },
	},
})
vim.cmd.colorscheme "cyberdream"

-- highlights
local mini_hipatterns = require "mini.hipatterns"
local mini_hiwords = require("mini.extra").gen_highlighter.words
mini_hipatterns.setup({
	highlighters = {
		hex_color = mini_hipatterns.gen_highlighter.hex_color(),
		fix = mini_hiwords({ "FIX", "TEMP" }, "MiniHipatternsFixme"),
		hack = mini_hiwords({ "HACK" }, "MiniHipatternsHack"),
		note = mini_hiwords({ "NOTE" }, "MiniHipatternsNote"),
		todo = mini_hiwords({ "TODO" }, "MiniHipatternsTodo"),
	},
})

--
-- FUNCTIONS
--

function theme:swap()
	if vim.g.colors_name == "cyberdream" then
		mini_base16.setup({
			palette = mini_base16.mini_palette("#2b1a33", "#c9c5cb", 128),
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
	else
		vim.cmd.colorscheme "cyberdream"
	end
end

--
-- MAPPINGS
--

theme:map("<space>", function()
	theme:swap()
end)

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
