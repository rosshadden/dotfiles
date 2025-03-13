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
		"~/.dotnet/tools",
	]
)

##
## prompt
##

def color [color: string] {
	each { $"(ansi $color)($in)(ansi reset)" }
}

def prompt_left [] {
	let dir = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
		null => $env.PWD
		"" => "~"
		$relative_pwd => ([~ $relative_pwd] | path join)
	}

	let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
	let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_blue_bold })
	let seg_path = $path_color + $dir

	$seg_path | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def prompt_right [] {
	let seg_time = (
		[
			(ansi reset)
			(ansi magenta)
			(date now | format date "%X")
		]
		| str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)"
	)

	let seg_vcs = (
		if (do { git rev-parse --abbrev-ref HEAD } | complete | get stderr | is-empty) {
			$"[(git rev-parse --abbrev-ref HEAD | str trim)]" | color yellow
		}
	)

	let seg_exit_code = if ($env.LAST_EXIT_CODE != 0) {
		([
			(ansi rb)
			($env.LAST_EXIT_CODE)
		] | str join)
	} else { "" }

	([
		$seg_exit_code
		$seg_vcs
		$seg_time
	] | str join (char space))
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { prompt_left }
$env.PROMPT_COMMAND_RIGHT = { prompt_right }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = "〉"
$env.PROMPT_INDICATOR_VI_INSERT = $": (ansi -e '6 q')"
$env.PROMPT_INDICATOR_VI_NORMAL = $"〉(ansi -e '2 q')"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

##
## setup
##

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
const NU_LIB_DIRS = [
	($nu.default-config-dir | path join modules)
	($nu.data-dir | path join 'completions')
	"~"
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
const NU_PLUGIN_DIRS = [
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

# tig
# NOTE: workaround because of https://github.com/jonas/tig/issues/1367
$env.GIT_EDITOR = "nvim"

# .NET
$env.DOTNET_ROLL_FORWARD = "LatestMajor"

##
## insurance
##

if ("~/local/config.nu" | path exists | not $in) {
	touch ~/local/config.nu
}
