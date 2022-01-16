-- reload config
function reload()
	for name, _ in pairs(package.loaded) do
		if name:match([[^core]]) then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.api.nvim_echo({ { "config reloaded", "None" } }, false, {})
end
