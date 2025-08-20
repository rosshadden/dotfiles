local yazi = Module.new("yazi")

--
-- EVENTS
--

-- generate config files from nuon
vim.api.nvim_create_autocmd("BufWrite", {
	group = yazi.group,
	pattern = "*/yazi/keymap.nuon",
	callback = function(event)
		local cmd = "open " .. event.file .. " | to toml | save -f ('" .. event.file .. "' | str replace .nuon .toml)"
		run(cmd, "nu")
	end,
})
