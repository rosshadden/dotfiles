local folds = Module.new("folds", "<space>z")

--
-- MAPPINGS
--

-- fold levels
folds:map("[", cmd "set foldlevel=0")
folds:map("0", cmd "set foldlevel=128")
for i = 1, 9, 1 do
	folds:map(i, cmd "set foldlevel=" .. i)
end

-- toggle folds
folds:map("<space>", "za")

-- create fold
folds:map("c", "zf")
