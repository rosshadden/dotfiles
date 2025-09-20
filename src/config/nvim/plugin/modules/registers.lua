local registers = Module.new("registers", "<space>r")

--
-- MAPPINGS
--

-- add to the `gp` and `gy` from mini.basics
map("gP", [["+P]])
map("gY", [["+Y]], { "n", "x" }, { remap = true })

-- system clipboard [CLIPBOARD]
registers:map("", [["+]])

-- selection clipboard [PRIMARY]
registers:map("s", [["*]])

-- blackhole register
registers:map("b", [["_]])

-- yank register
registers:map("y", [["0]])

-- delete register
registers:map("d", [["1]])

-- small-delete register
registers:map("D", [["-]])

-- search register
registers:map("/", [["/]])

-- expression register
registers:map("=", [["=]])

-- read-only

-- insert register
registers:map("i", [[".]])

-- command register
registers:map(";", [[":]])

-- file register
registers:map("f", [["%]])

-- alt-file register
registers:map("F", [["#]])
