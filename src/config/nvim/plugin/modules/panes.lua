local panes = Module.new("panes", "<space>p")

local mini_pick = require "mini.pick"

--
-- SETTINGS
--

-- vim.o.switchbuf = "usetab"

--
-- MAPPINGS
--

-- choose
panes:map("<space>", mini_pick.registry.buffers)

-- relative nav
map("<a-j>", function() pcall(vim.cmd, "wincmd j") end, { "n", "v", "o", "t" })
map("<a-k>", function() pcall(vim.cmd, "wincmd k") end, { "n", "v", "o", "t" })
map("<a-h>", function() pcall(vim.cmd, "wincmd h") end, { "n", "v", "o", "t" })
map("<a-l>", function() pcall(vim.cmd, "wincmd l") end, { "n", "v", "o", "t" })
map("<a-n>", cmd "bnext")
map("<a-p>", cmd "bprevious")

-- stack nav
panes:map("n", cmd "bnext")
panes:map("p", cmd "bprevious")
panes:map("N", cmd "blast")
panes:map("P", cmd "bfirst")

-- switch to alternate buffer
panes:map("a", "<c-^>")

-- split [wasd]
panes:map("j", cmd "rightbelow new")
panes:map("k", cmd "leftabove new")
panes:map("h", cmd "leftabove vnew")
panes:map("l", cmd "rightbelow vnew")

-- clone [wasd]
panes:map("J", cmd "rightbelow split")
panes:map("K", cmd "leftabove split")
panes:map("H", cmd "leftabove vsplit")
panes:map("L", cmd "rightbelow vsplit")

-- close
map("<a-q>", cmd "bdelete")
panes:map("c", cmd "bdelete")
panes:map("C", cmd "bdelete!")
panes:map("d", cmd "bdelete")
panes:map("D", cmd "bdelete!")

-- quit
panes:map("q", cmd "quit")
panes:map("Q", cmd "quit!")

-- write
map("<c-s-s>", cmd "write")
panes:map("w", cmd "write")
panes:map("W", cmd "write!")

-- save
panes:map("S", cmd "update!")
panes:map("s", cmd "update")

-- exit
panes:map("x", cmd "exit")
panes:map("X", cmd "exit!")

-- reload
panes:map("r", cmd "edit")
panes:map("R", cmd "edit!")

-- source
panes:map("u", cmd "source")
