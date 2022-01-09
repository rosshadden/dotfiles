-- reload config
function reload()
	for name, _ in pairs(package.loaded) do
		if name:match([[^core]]) then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	print("reloaded config")
end
