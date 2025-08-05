local templates = Mode.new("templates")

local conf = vim.fn.stdpath "config"

--
-- EVENTS
--

-- TODO: check/load templates automatically, based on `event.file`

vim.api.nvim_create_autocmd("BufNewFile", {
	group = templates.group,
	pattern = "*.sh",
	callback = function(ev)
		vim.cmd("0r " .. conf .. "/templates/template.sh | normal Gdd")
	end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
	group = templates.group,
	pattern = "*.html",
	callback = function(ev)
		print(string.format('event fired: %s', vim.inspect(ev)))
		vim.cmd("0r " .. conf .. "/templates/template.html | normal Gdd10G$")
	end,
})
