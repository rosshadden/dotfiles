# make gpg open in-terminal dialog
let-env GPG_TTY = (if ($env | get -i GPG_TTY | empty?) { tty | str trim } else { $env.GPG_TTY })

let-env FZF_DEFAULT_COMMAND = "fd --type file --hidden --follow"
let-env FZF_DEFAULT_OPTS = ([
	"--cycle"
	"--bind 'alt-enter:print-query,tab:toggle-up,ctrl-y:execute-silent(echo {} | copy)'"
	"--preview 'bat --line-range :500 {}'"
] | str collect " ")

##
## settings
##

let-env EDITOR = "nvim"
let-env BROWSER = "google-chrome-stable"
# let-env KEYBOARD = "/dev/input/by-id/usb-Razer_Razer_BlackWidow_Ultimate-event-kbd"
let-env KEYBOARD = "/dev/input/by-id/usb-Razer_Razer_BlackWidow_Ultimate-if01-event-kbd"

##
## apps
##

# nodejs
let-env N_PREFIX = "~/local"

# steam
let-env STEAM_COMPAT_DATA_PATH = "/media/data/games/proton/"

# godot
let-env GODOT_BIN = "/usr/bin/godot"

# sensible pagers
let-env PAGER = "less -FRSX"
let-env MANPAGER = "sh -c 'col -bx | bat --language man --plain'"

##
## path
##

let-env PATH = (
	$env.PATH
	| prepend [
		# personal
		"/home/ross/bin",
		"/home/ross/local/bin",
		"/home/ross/.local/bin",

		# domain
		"/home/ross/dev/bin",
		"/home/ross/dev/reaction/bin",
		"/home/ross/dev/mailchimp/bin",
	]
	| append [
		# system
		"/usr/local/sbin",
		"/usr/sbin",

		# lang
		"/home/ross/.nimble/bin",
		"/home/ross/.cargo/bin",
		"/home/ross/go/bin",
		"/home/ross/.rvm/bin",
		"/home/ross/.gem/ruby/3.0.0/bin",
		"/usr/bin/core_perl",
		"/usr/lib/jvm/java-7-openjdk/jre/bin",
	]
)
