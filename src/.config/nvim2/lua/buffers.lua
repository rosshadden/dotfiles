-- relative navigation
map("<a-j>", function() pcall(vim.cmd, "wincmd j") end, { modes = "" })
map("<a-k>", function() pcall(vim.cmd, "wincmd k") end, { modes = "" })
map("<a-h>", function() pcall(vim.cmd, "wincmd h") end, { modes = "" })
map("<a-l>", function() pcall(vim.cmd, "wincmd l") end, { modes = "" })

-- crud
map("<leader>w", ":write<cr>")
map("<leader>s", ":update<cr>")
map("<leader>q", ":quit<cr>")
map("<leader>x", ":exit<cr>")
map("<a-q>", ":bdelete<cr>")
