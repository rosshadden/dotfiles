local subwords = Module.new("subwords", "<space>s")

pack("chrisgrieser/nvim-spider")

local mini_extra = require "mini.extra"
local spider = require "spider"

--
-- SETUP
--

require "mini.indentscope".setup()

require "mini.operators".setup({
	replace = {
		prefix = "g.",
	},
})

require "mini.ai".setup({
	custom_textobjects = {
		-- current line/row
		r = mini_extra.gen_ai_spec.line(),

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

--
-- MAPPINGS
--

-- spider

map("<leader>b", function() spider.motion("b") end)
map("<leader>e", function() spider.motion("e") end)
map("<leader>w", function() spider.motion("w") end)
