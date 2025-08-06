local app = Mode.new("app", "<space>a")

--
-- SETUP
--

require "mini.bracketed".setup()
require "mini.extra".setup()

require "mini.basics".setup({
	extra_ui = true,
})

--
-- FUNCTIONS
--

--- Reload config.
--- FIX: not working
local function reload()
	for name, _ in pairs(package.loaded) do
		if name:match "^core" then
			package.loaded[name] = nil
		end
	end
	-- TEMP: change to `vim.env.MYVIMRC` if these ever replace may main config
	dofile "/home/ross/dotfiles/src/.config/nvim2/init.lua"
	vim.api.nvim_echo({ { "config reloaded" } }, false, {})
end

--
-- MAPPINGS
--

-- quit
app:map("q", cmd "quitall")
app:map("Q", cmd "quitall!")

-- error
app:map("e", cmd "cquit")
app:map("E", cmd "cquit!")

-- write
app:map("w", cmd "wall")
app:map("W", cmd "wall!")

-- exit
app:map("x", cmd "xall")
app:map("X", cmd "xall!")

-- close
app:map("c", cmd "bufdo bdelete")
app:map("C", cmd "bufdo bdelete!")

-- reload
app:map("r", reload)
app:map("R", cmd "restart")

-- messages
app:map("m", cmd "messages")
app:map("M", cmd "messages clear")
