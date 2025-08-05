local app = Mode.new("app", "<space>a")

--
-- FUNCTIONS
--

--- Reload config.
local function reload()
	for name, _ in pairs(package.loaded) do
		if name:match("^core") then
			package.loaded[name] = nil
		end
	end
	-- TEMP: change to `vim.env.MYVIMRC` if these ever replace may main config
	dofile("/home/ross/dotfiles/src/.config/nvim2/init.lua")
	vim.api.nvim_echo({ { "config reloaded" } }, false, {})
end

--
-- MAPPINGS
--

-- crud
app:map("q", cmd "quitall")

app:map("r", reload)
app:map("R", cmd "restart")
