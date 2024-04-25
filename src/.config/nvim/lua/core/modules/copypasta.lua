--
-- MAPPINGS
--

-- prefix
vim.keymap.set({ "n", "v" }, "<space>c", "<plug><copy>", { silent = true })

-- system clipboard [CLIPBOARD]
vim.keymap.set({ "n", "v" }, "<plug><copy>", [["+]], { silent = true, noremap = true })

-- selection clipboard [PRIMARY]
vim.keymap.set({ "n", "v" }, "<plug><copy>s", [["*]], { silent = true, noremap = true })

-- blackhole register
vim.keymap.set({ "n", "v" }, "<plug><copy>b", [["_]], { silent = true, noremap = true })

-- yank register
vim.keymap.set({ "n", "v" }, "<plug><copy><c-y>", [["0]], { silent = true, noremap = true })

-- delete register
vim.keymap.set({ "n", "v" }, "<plug><copy><c-d>", [["1]], { silent = true, noremap = true })

-- small-delete register
vim.keymap.set({ "n", "v" }, "<plug><copy><c-s-d>", [["-]], { silent = true, noremap = true })

-- search register
vim.keymap.set({ "n", "v" }, "<plug><copy>/", [["/]], { silent = true, noremap = true })

-- expression register
vim.keymap.set({ "n", "v" }, "<plug><copy>=", [["=]], { silent = true, noremap = true })

-- read-only

-- insert register
vim.keymap.set({ "n", "v" }, "<plug><copy>i", [[".]], { silent = true, noremap = true })

-- command register
vim.keymap.set({ "n", "v" }, "<plug><copy>;", [[":]], { silent = true, noremap = true })

-- file register
vim.keymap.set({ "n", "v" }, "<plug><copy>f", [["%]], { silent = true, noremap = true })

-- alt-file register
vim.keymap.set({ "n", "v" }, "<plug><copy>F", [["#]], { silent = true, noremap = true })
