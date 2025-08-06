local copypasta = Module.new("copypasta", "<space>c")

--
-- MAPPINGS
--

-- system clipboard [CLIPBOARD]
copypasta:map("", [["+]], "")

-- selection clipboard [PRIMARY]
copypasta:map("s", [["*]], "")

-- blackhole register
copypasta:map("b", [["_]], "")

-- yank register
copypasta:map("<c-y>", [["0]], "")

-- delete register
copypasta:map("<c-d>", [["1]], "")

-- small-delete register
copypasta:map("<c-s-d>", [["-]], "")

-- search register
copypasta:map("/", [["/]], "")

-- expression register
copypasta:map("=", [["=]], "")

-- read-only

-- insert register
copypasta:map("i", [[".]], "")

-- command register
copypasta:map(";", [[":]], "")

-- file register
copypasta:map("f", [["%]], "")

-- alt-file register
copypasta:map("F", [["#]], "")
