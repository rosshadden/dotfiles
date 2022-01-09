lua <<LUA
require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'bash',
		'c',
		'c_sharp',
		'clojure',
		'cpp',
		'dockerfile',
		'gdscript',
		'go',
		'godotResource',
		'html',
		'javascript',
		'json',
		'lua',
		'php',
		'python',
		'toml',
		'tsx',
		-- 'org',
		'typescript',
		'yaml',
	},
	highlight = { enable = true },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
}

require('orgmode').setup({
	org_agenda_files = {},
	org_default_notes_file = '~/dev/lit/org/refile.org',
})
LUA
