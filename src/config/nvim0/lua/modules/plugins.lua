local lazy = require("lazy")

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>P", "<plug><plugins>", { silent = true })

-- update
vim.keymap.set("n", "<plug><plugins>u", lazy.update, { silent = true })
