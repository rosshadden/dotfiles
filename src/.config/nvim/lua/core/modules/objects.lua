local polyword = require "polyword"

--
-- FUNCTIONS
--

local makeTextobject = function(keys, fn)
	vim.keymap.set("x", keys, fn, { silent = true })
	vim.keymap.set("o", keys, function() vim.api.nvim_feedkeys("v" .. keys, "x", true) end, { silent = true })
end

--
-- MAPPINGS
--

-- polyword

-- prefix
vim.keymap.set("", "<space>p", "<plug><put-in-motion>", { silent = true })
vim.keymap.set("", "<space>s", "<plug><sort-in-motion>", { silent = true })
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

-- in/around line

makeTextobject("il", function()
	vim.api.nvim_feedkeys("^og_", "xt", true)
end)

makeTextobject("al", function()
	vim.api.nvim_feedkeys("0o$", "xt", true)
end)

-- around everything

makeTextobject("ae", function()
	vim.api.nvim_feedkeys("gg0oG$", "xt", true)
end)

-- in/around line

makeTextobject("ii", function()
	if vim.api.nvim_get_current_line() == "" then return end

	local pos = vim.api.nvim_win_get_cursor(0)
	local lastLine = vim.api.nvim_buf_line_count(0)
	local line = pos[1]
	local selection = { line, line }
	local level = vim.fn.indent(line)

	local l = line
	while l > 1 do
		l = l - 1
		if vim.fn.indent(l) < level then break end
		selection[1] = l
	end

	l = line
	while l < lastLine do
		l = l + 1
		if vim.fn.indent(l) < level then break end
		selection[2] = l
	end

	-- print("debug", vim.api.nvim_get_current_line() == "")
	vim.api.nvim_feedkeys(selection[1] .. "G0o" .. selection[2] .. "G$", "xt", true)
end)

-- TODO: not working yet
makeTextobject("ai", function()
	if vim.api.nvim_get_current_line() == "" then return end

	local pos = vim.api.nvim_win_get_cursor(0)
	local lastLine = vim.api.nvim_buf_line_count(0)
	local line = pos[1]
	local selection = { line, line }
	local level = vim.fn.indent(line)

	local l = line
	while l > 1 and (vim.fn.indent(l) >= level or vim.fn.getline(line) == "") do
		l = l - 1
	end
	selection[1] = l

	l = line
	while l < lastLine and (vim.fn.indent(l) >= level or vim.fn.getline(line) == "") do
		l = l + 1
	end
	selection[2] = l

	-- print("debug", vim.api.nvim_get_current_line() == "")
	vim.api.nvim_feedkeys(selection[1] .. "G0o" .. selection[2] .. "G$", "xt", true)
end)
