def color [color: string] {
	each { |it| $"(ansi $color)($it)(ansi reset)" }
}

def promptLeft [] {
	$"(ansi osc)2;($env.PWD)"
	$"(ansi osc)7;file://localhost($env.PWD)"
	([
		($env.PWD)
	] | str join)
}

def promptRight [] {
	([
		(if (do { git rev-parse --abbrev-ref HEAD } | complete | get stderr | is-empty) {
			(""
				+ "["
				+ (git rev-parse --abbrev-ref HEAD | str trim)
				+ "] "
			) | color red
		})
		(date now | date format "%T" | color purple)
	] | str join)
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { promptLeft }
let-env PROMPT_COMMAND_RIGHT = { promptRight }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = "〉"
let-env PROMPT_INDICATOR_VI_INSERT = $": (ansi -e '6 q')"
let-env PROMPT_INDICATOR_VI_NORMAL = $"〉(ansi -e '2 q')"
let-env PROMPT_MULTILINE_INDICATOR = "::: "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
	PATH: {
		from_string: { |s| $s | split row (char esep) }
		to_string: { |v| $v | path expand | str join (char esep) }
	}
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
	($nu.config-path | path dirname | path join modules)
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
	($nu.config-path | path dirname | path join plugins)
]
