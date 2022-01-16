local telescope = require("telescope.builtin")
local tmuxNav = require("nvim-tmux-navigation")

--
-- SETTINGS
--

-- let buffers exist in the background
vim.opt.hidden = true

-- more natural splits
vim.opt.splitbelow = true
vim.opt.splitright = true

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>b", "<plug><buffers>", { silent = true })

-- switch to alternate buffer
vim.keymap.set("n", "<leader>b", "<c-^>", { silent = true })

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
vim.keymap.set("n", "<a-c>", ":bdelete<cr>", { silent = true })
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

-- reload
vim.keymap.set("n", "<plug><buffers>r", ":edit<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>R", ":edit!<cr>", { silent = true })

-- choose
vim.keymap.set("n", "<plug><buffers><space>", telescope.buffers, { silent = true })

-- navigation
vim.keymap.set("n", "<plug><buffers>n", ":bnext<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>p", ":bprevious<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>N", ":blast<cr>", { silent = true })
vim.keymap.set("n", "<plug><buffers>P", ":bfirst<cr>", { silent = true })

-- tmux
vim.keymap.set({ "", "i" }, "<c-j>", tmuxNav.NvimTmuxNavigateDown, { silent = true })
vim.keymap.set({ "", "i" }, "<c-k>", tmuxNav.NvimTmuxNavigateUp, { silent = true })
vim.keymap.set({ "", "i" }, "<c-h>", tmuxNav.NvimTmuxNavigateLeft, { silent = true })
vim.keymap.set({ "", "i" }, "<c-l>", tmuxNav.NvimTmuxNavigateRight, { silent = true })
vim.keymap.set({ "", "i" }, "<c-bs>", tmuxNav.NvimTmuxNavigateLastActive, { silent = true })

--
-- SETUP
--

tmuxNav.setup {
	disable_when_zoomed = true,
}
