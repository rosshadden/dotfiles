##
## path
##

$env.PATH = (
	$env.PATH
	| prepend [
		# personal
		"~/bin",
		"~/local/bin",
		"~/.local/bin",

		# domain
		"~/dev/bin",

		# apps
		"~/.local/share/fnm/aliases/default/bin",
	]
	| append [
		# system
		"/opt/homebrew/bin",

		# lang
		"~/.bun/bin",
		"~/.cargo/bin",
		"~/.gem/ruby/3.0.0/bin",
		"~/.nimble/bin",
		"~/.rvm/bin",
		"~/go/bin",
	]
)

##
## prompt
##

def color [color: string] {
	each { |it| $"(ansi $color)($it)(ansi reset)" }
}

def promptLeft [] {
	$"(ansi osc)2;($env.PWD)"
	$"(ansi osc)7;file://localhost($env.PWD)"
	([
		($env.PWD | str replace $env.HOME ~)
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
		(date now | format date "%T" | color purple)
	] | str join)
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { promptLeft }
$env.PROMPT_COMMAND_RIGHT = { promptRight }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = "〉"
$env.PROMPT_INDICATOR_VI_INSERT = $": (ansi -e '6 q')"
$env.PROMPT_INDICATOR_VI_NORMAL = $"〉(ansi -e '2 q')"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

##
## setup
##

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
	PATH: {
		from_string: { |s| $s | split row (char esep) }
		to_string: { |v| $v | path expand | str join (char esep) }
	}
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
	($nu.config-path | path dirname | path join modules),
	"~",
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
	($nu.config-path | path dirname | path join plugins)
]

##
## settings
##

# make gpg open in-terminal dialog
$env.GPG_TTY = (tty | str trim)

$env.EDITOR = "nvim"
$env.BROWSER = "thorium-browser"

##
## display
##

$env.XCURSOR_SIZE = 32

##
## apps
##

# fzf
$env.FZF_DEFAULT_COMMAND = "fd --type file --hidden --follow"
$env.FZF_DEFAULT_OPTS = ([
		"--cycle"
		"--bind 'alt-enter:print-query,tab:toggle-up,ctrl-y:execute-silent(echo {} | copy)'"
		"--preview 'bat --line-range :500 {}'"
	] | str join " ")

# nodejs
$env.N_PREFIX = "~/local"

# steam
$env.STEAM_COMPAT_DATA_PATH = "/media/data/games/proton/"

# godot
$env.GODOT_BIN = "/usr/bin/godot"

# sensible pagers
$env.PAGER = "less -FRSX"
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
$env.MANROFFOPT = "-c"

# pass
$env.PASSWORD_STORE_ENABLE_EXTENSIONS = "true" # [sic]
