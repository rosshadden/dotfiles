pack "waiting-for-dev/ergoterm.nvim"

--
-- SETUP
--

require("ergoterm").setup()

--
-- MODULE
--

utils = {
	Term = require("ergoterm.terminal").Terminal,
}
