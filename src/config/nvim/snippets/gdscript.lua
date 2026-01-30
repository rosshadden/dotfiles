return {

	["print"] = {
		prefix = "pp",
		body = [[print($1)]],
	},

	["print with spaces"] = {
		prefix = "p",
		body = [[prints($1)]],
	},

	["print with tabs"] = {
		prefix = "pt",
		body = [[printt($1)]],
	},

	["print text"] = {
		prefix = "log",
		body = [[prints("$1")]],
	},

	["print error"] = {
		prefix = "pe",
		body = [[printerr($1)]],
	},

	["print raw"] = {
		prefix = "pr",
		body = [[printraw($1)]],
	},

	["print debug"] = {
		prefix = "pd",
		body = [[print_debug($1)]],
	},

	["print tree"] = {
		prefix = "ptree",
		body = [[print_tree($1)]],
	},

	["print tree pretty"] = {
		prefix = "ptreep",
		body = [[print_pretty_tree($1)]],
	},

	["print rich"] = {
		prefix = "prich",
		body = [[print_rich($1)]],
	},

	["breakpoint"] = {
		prefix = "b",
		body = [[breakpoint]],
	},

}
