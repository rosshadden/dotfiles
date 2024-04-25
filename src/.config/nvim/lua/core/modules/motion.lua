local hop = require "hop"
local hop_ts = require "hop-treesitter"
local hints = require "hop.hint"

--
-- VARIABLES
--

local jump_pattern_vertical = [[\v(<.|^$)|(.>|^$)|(\l)\zs(\u)|(_\zs.)|(#\zs.)]]

--
-- SETTINGS
--

hop.setup {
	keys = [[cieansthbyouvwldj-/mkr,.]]
}

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("", "<tab>", "<plug><motion>", { silent = true })

-- directions

vim.keymap.set("", "<plug><motion>j", function()
	hop.hint_vertical({ direction = hints.HintDirection.AFTER_CURSOR })
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>k", function()
	hop.hint_vertical({ direction = hints.HintDirection.BEFORE_CURSOR })
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>h", function()
	hop.hint_patterns({ direction = hints.HintDirection.BEFORE_CURSOR, current_line_only = true }, jump_pattern_vertical)
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>l", function()
	hop.hint_patterns({ direction = hints.HintDirection.AFTER_CURSOR, current_line_only = true }, jump_pattern_vertical)
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>v", hop.hint_vertical, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>s", function()
	hop.hint_patterns({ current_line_only = true }, jump_pattern_vertical)
end, { silent = true, noremap = true })

-- textobjects

vim.keymap.set("", "<plug><motion>w", function()
	hop.hint_words({ direction = hints.HintDirection.AFTER_CURSOR })
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>W", function()
	hop.hint_patterns({ direction = hints.HintDirection.AFTER_CURSOR }, [[\v(^|\s)@<=\S+]])
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>b", function()
	hop.hint_words({ direction = hints.HintDirection.BEFORE_CURSOR })
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>B", function()
	hop.hint_patterns({ direction = hints.HintDirection.BEFORE_CURSOR }, [[\v(^|\s)@<=\S+]])
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>e", function()
	hop.hint_patterns({ direction = hints.HintDirection.AFTER_CURSOR }, [[\v\w>]])
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>E", function()
	hop.hint_patterns({ direction = hints.HintDirection.AFTER_CURSOR }, [[\v\S(\s|$)@!]])
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>ge", function()
	hop.hint_patterns({ direction = hints.HintDirection.BEFORE_CURSOR }, [[\v\w>]])
end, { silent = true, noremap = true })

-- sneaking
vim.keymap.set("", "<plug><motion><cr>", hop.hint_char1, { silent = true, noremap = true })
vim.keymap.set("", "<plug><motion><tab>", hop.hint_char2, { silent = true, noremap = true })

-- characters

vim.keymap.set("", "<plug><motion>f", function()
	hop.hint_char1({ direction = hints.HintDirection.AFTER_CURSOR })
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>F", function()
	hop.hint_char1({ direction = hints.HintDirection.BEFORE_CURSOR })
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>t", function()
	hop.hint_char1({ direction = hints.HintDirection.AFTER_CURSOR, hint_offset = -1 })
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>T", function()
	hop.hint_char1({ direction = hints.HintDirection.BEFORE_CURSOR, hint_offset = 1 })
end, { silent = true, noremap = true })

-- patterns

vim.keymap.set("", "<plug><motion>/", hop.hint_patterns, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>?", function()
	hop.hint_patterns({ direction = hints.HintDirection.BEFORE_CURSOR })
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>!", function()
	hop.hint_patterns({ direction = hints.HintDirection.AFTER_CURSOR })
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>n", function()
	hop.hint_patterns({}, vim.fn.getreg("/"))
end, { silent = true, noremap = true })

vim.keymap.set("", "<plug><motion>N", function()
	hop.hint_patterns({ direction = hints.HintDirection.AFTER_CURSOR }, vim.fn.getreg("/"))
end, { silent = true, noremap = true })

-- anywhere

vim.keymap.set("", "<plug><motion>a", function()
	hop.hint_anywhere()
end, { silent = true, noremap = true })

-- integration

vim.keymap.set("", "<plug><motion>r", function()
	hop_ts.hint_nodes()
end, { silent = true, noremap = true })
