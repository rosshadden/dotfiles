local buffers = Module.new("buffers", "<space>b")

--
-- MAPPINGS
--

-- relative navigation
map("<a-j>", function() pcall(vim.cmd, "wincmd j") end, { modes = {} })
map("<a-k>", function() pcall(vim.cmd, "wincmd k") end, { modes = {} })
map("<a-h>", function() pcall(vim.cmd, "wincmd h") end, { modes = {} })
map("<a-l>", function() pcall(vim.cmd, "wincmd l") end, { modes = {} })

-- stack navigation
buffers:map("n", cmd "bnext")
buffers:map("p", cmd "bprevious")
buffers:map("N", cmd "blast")
buffers:map("P", cmd "bfirst")

-- switch to alternate buffer
vim.keymap.set("n", "<leader>b", "<c-^>", { silent = true })

-- split [wasd]
buffers:map("j", cmd "rightbelow new")
buffers:map("k", cmd "leftabove new")
buffers:map("h", cmd "leftabove vnew")
buffers:map("l", cmd "rightbelow vnew")

-- clone [wasd]
buffers:map("J", cmd "rightbelow split")
buffers:map("K", cmd "leftabove split")
buffers:map("H", cmd "leftabove vsplit")
buffers:map("L", cmd "rightbelow vsplit")

-- close
map("<a-q>", cmd "bdelete")
buffers:map("c", cmd "bdelete")
buffers:map("C", cmd "bdelete!")
buffers:map("d", cmd "bdelete")
buffers:map("D", cmd "bdelete!")

-- quit
buffers:map("q", cmd "quit")
buffers:map("Q", cmd "quit!")

-- write
buffers:map("w", cmd "write")
buffers:map("W", cmd "write!")

-- save
buffers:map("s", cmd "update")
buffers:map("S", cmd "update!")

-- exit
buffers:map("x", cmd "exit")
buffers:map("X", cmd "exit!")

-- reload
buffers:map("r", cmd "edit")
buffers:map("R", cmd "edit!")

-- choose
buffers:map("<space>", function()
	MiniPick.builtin.buffers()
end)
