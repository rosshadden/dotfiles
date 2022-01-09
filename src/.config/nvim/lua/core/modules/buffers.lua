-- prefix
vim.keymap.set("n", "<space>b", "<plug><buffers>", { silent = true })

-- split [j, k, h, l]
vim.keymap.set("n", "<plug><buffers>j", ":rightbelow new<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>k", ":leftabove new<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>h", ":leftabove vnew<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>l", ":rightbelow vnew<cr>", { silent = true })

-- clone [j, k, h, l]
vim.keymap.set("n", "<plug><buffers>J", ":rightbelow split<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>K", ":leftabove split<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>H", ":leftabove vsplit<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>L", ":rightbelow vsplit<cr>", { silent = true })

-- close
vim.keymap.set("n", "<plug><buffers>c", ":bdelete<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>C", ":bdelete!<cr>", { silent = true })

-- quit
vim.keymap.set("n", "<plug><buffers>q", ":quit<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>Q", ":quit!<cr>", { silent = true })

-- write
vim.keymap.set("n", "<plug><buffers>w", ":write<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>W", ":write!<cr>", { silent = true })

-- save
vim.keymap.set("n", "<plug><buffers>s", ":update<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>S", ":update!<cr>", { silent = true })

-- exit
vim.keymap.set("n", "<plug><buffers>x", ":xit<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>X", ":xit!<cr>", { silent = true })

----------------
-- plugins
----------------

require("nvim-tmux-navigation").setup({
    disable_when_zoomed = true,
    keybindings = {
	left = "<c-h>",
	down = "<c-j>",
	up = "<c-k>",
	right = "<c-l>",
	last_active = "<c-bs>",
    }
})
