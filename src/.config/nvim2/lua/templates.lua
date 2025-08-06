local templates = Mode.new("templates")

local conf = vim.fn.stdpath "config"

local function template(kind)
	return conf .. "/templates/t." .. kind
end

--
-- EVENTS
--

-- TODO: check/load templates automatically, based on `event.file`

vim.api.nvim_create_autocmd("BufNewFile", {
	group = templates.group,
	pattern = "*.sh",
	callback = function(ev)
		vim.cmd("0r " .. template("sh") .. " | normal Gdd")
	end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
	group = templates.group,
	pattern = "*.html",
	callback = function(ev)
		vim.cmd("0r " .. template("html") .. " | normal Gdd10G$")
	end,
})
