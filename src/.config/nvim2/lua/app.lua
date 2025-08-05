--- Reload config.
function reload()
	for name, _ in pairs(package.loaded) do
		if name:match("^core") then
			package.loaded[name] = nil
		end
	end

	dofile("/home/ross/dotfiles/src/.config/nvim2/init.lua")
	vim.api.nvim_echo({ { "config reloaded", "None" } }, false, {})
end

map("<leader>u", reload)
map("<leader>r", ":restart<cr>")
