local windows = Module.new("windows", "<space>w")

--
-- SETTINGS
--

-- window title
vim.opt.title = true

--
-- MAPPINGS
--

-- navigation
windows:map("n", cmd "wnext")
windows:map("p", cmd "wprevious")

-- split [j, k, h, l]
windows:map("j", cmd "botright new")
windows:map("k", cmd "topleft new")
windows:map("h", cmd "topleft vnew")
windows:map("l", cmd "botright vnew")

-- move window [H, J, K, L]
-- NOTE: this is not expected, but all vim can natively do
windows:map("J", "<c-w>J")
windows:map("K", "<c-w>K")
windows:map("H", "<c-w>H")
windows:map("L", "<c-w>L")

-- close
windows:map("c", cmd "close")
windows:map("C", cmd "close!")

-- close all other windows
windows:map("o", "<c-w>O")

-- move window to a new tab
windows:map("t", "<c-w>T")
