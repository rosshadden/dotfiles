local copypasta = Module.new("copypasta", "<space>c")

--
-- MAPPINGS
--

local options = { modes = { "n", "v" }, noremap = true }

-- system clipboard [CLIPBOARD]
copypasta:map("", [["+]], options)

-- selection clipboard [PRIMARY]
copypasta:map("s", [["*]], options)

-- blackhole register
copypasta:map("b", [["_]], options)

-- yank register
copypasta:map("<c-y>", [["0]], options)

-- delete register
copypasta:map("<c-d>", [["1]], options)

-- small-delete register
copypasta:map("<c-s-d>", [["-]], options)

-- search register
copypasta:map("/", [["/]], options)

-- expression register
copypasta:map("=", [["=]], options)

-- read-only

-- insert register
copypasta:map("i", [[".]], options)

-- command register
copypasta:map(";", [[":]], options)

-- file register
copypasta:map("f", [["%]], options)

-- alt-file register
copypasta:map("F", [["#]], options)
