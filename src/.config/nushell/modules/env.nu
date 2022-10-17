export-env {
	# make gpg open in-terminal dialog
	let-env GPG_TTY = (tty | str trim)

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
}
