local motion = Module.new("motion", "<tab>")

pack({
	"chrisgrieser/nvim-spider",
	"smoka7/hop.nvim",
})

local hop = require "hop"

--
-- SETUP
--

require("mini.indentscope").setup()
require("mini.jump2d").setup()

require("mini.operators").setup({
	replace = {
		prefix = "g.",
	},
})

require("mini.ai").setup({
	custom_textobjects = {
		-- current line/row
		r = require("mini.extra").gen_ai_spec.line(),

		-- entire buffer
		e = function()
			local from = { line = 1, col = 1 }
			local to = {
				line = vim.fn.line('$'),
				col = math.max(vim.fn.getline('$'):len(), 1)
			}
			return { from = from, to = to, vis_mode = 'V' }
		end
	}
})

hop.setup({
	keys = [[cnisetahywodulxfjmkr,.-/]]
})

--
-- MAPPINGS
--

-- spider

local spider = require "spider"

map("<leader>b", function() spider.motion("b") end)
map("<leader>e", function() spider.motion("e") end)
map("<leader>w", function() spider.motion("w") end)

-- hop

local hop_yank = require("hop-yank")
local hints = require("hop.hint").HintDirection
local patterns = {
	Word = [[\v(^|\s)@<=\S+]],
	eoW = [[\v\S(\s|$)@!]],
	vert = [[\v(<.|^$)|(.>|^$)|(\l)\zs(\u)|(_\zs.)|(#\zs.)]],
	word = [[\v\w>]],
}

-- directions
motion:map("j", function()
	hop.hint_vertical({ direction = hints.AFTER_CURSOR })
end, "")
motion:map("k", function()
	hop.hint_vertical({ direction = hints.BEFORE_CURSOR })
end, "")
motion:map("h", function()
	hop.hint_patterns({ direction = hints.BEFORE_CURSOR, current_line_only = true }, patterns.vert)
end, "")
motion:map("l", function()
	hop.hint_patterns({ direction = hints.AFTER_CURSOR, current_line_only = true }, patterns.vert)
end, "")
motion:map("v", hop.hint_vertical, "")
motion:map("s", function()
	hop.hint_patterns({ current_line_only = true }, patterns.vert)
end, "")

-- textobjects
motion:map("w", function()
	hop.hint_words({ direction = hints.AFTER_CURSOR })
end, "")
motion:map("W", function()
	hop.hint_patterns({ direction = hints.AFTER_CURSOR }, patterns.Word)
end, "")
motion:map("b", function()
	hop.hint_words({ direction = hints.BEFORE_CURSOR })
end, "")
motion:map("B", function()
	hop.hint_patterns({ direction = hints.BEFORE_CURSOR }, patterns.Word)
end, "")
motion:map("e", function()
	hop.hint_patterns({ direction = hints.AFTER_CURSOR }, patterns.word)
end, "")
motion:map("E", function()
	hop.hint_patterns({ direction = hints.AFTER_CURSOR }, patterns.eoW)
end, "")
motion:map("ge", function()
	hop.hint_patterns({ direction = hints.BEFORE_CURSOR }, patterns.word)
end, "")

-- sneaking
motion:map("<tab>", hop.hint_char1, "")
motion:map("<cr>", hop.hint_char2, "")

-- characters
motion:map("f", function()
	hop.hint_char1({ direction = hints.AFTER_CURSOR })
end, "")
motion:map("F", function()
	hop.hint_char1({ direction = hints.BEFORE_CURSOR })
end, "")
motion:map("t", function()
	hop.hint_char1({ direction = hints.AFTER_CURSOR, hint_offset = -1 })
end, "")
motion:map("T", function()
	hop.hint_char1({ direction = hints.BEFORE_CURSOR, hint_offset = 1 })
end, "")

-- patterns
motion:map("/", hop.hint_patterns, "")
motion:map("?", function()
	hop.hint_patterns({ direction = hints.BEFORE_CURSOR })
end, "")
motion:map("!", function()
	hop.hint_patterns({ direction = hints.AFTER_CURSOR })
end, "")
motion:map("n", function()
	hop.hint_patterns({}, vim.fn.getreg("/"))
end, "")
motion:map("N", function()
	hop.hint_patterns({ direction = hints.AFTER_CURSOR }, vim.fn.getreg("/"))
end, "")

-- anywhere
motion:map("a", hop.hint_anywhere, "")

-- actions
motion:map("y", hop_yank.yank_char1, "")
motion:map("p", hop_yank.paste_char1, "")
