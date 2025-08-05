local buffers = Mode.new("buffers", "<space>b")

--
-- MAPPINGS
--

-- relative navigation
map("<a-j>", function() pcall(vim.cmd, "wincmd j") end, { modes = "" })
map("<a-k>", function() pcall(vim.cmd, "wincmd k") end, { modes = "" })
map("<a-h>", function() pcall(vim.cmd, "wincmd h") end, { modes = "" })
map("<a-l>", function() pcall(vim.cmd, "wincmd l") end, { modes = "" })

-- crud
buffers:map("q", cmd "quit")
buffers:map("s", cmd "update")
buffers:map("w", cmd "write")
buffers:map("x", cmd "exit")
map("<a-q>", cmd "bdelete")
