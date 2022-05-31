local packer = require("packer")

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>P", "<plug><plugins>", { silent = true })

-- update
vim.keymap.set("n", "<plug><plugins>u", packer.sync, { silent = true })
