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
buffers:map("q", ":quit<cr>")
buffers:map("s", ":update<cr>")
buffers:map("w", ":write<cr>")
buffers:map("x", ":exit<cr>")
map("<a-q>", ":bdelete<cr>")
