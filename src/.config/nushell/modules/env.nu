# make gpg open in-terminal dialog
export env GPG_TTY { (if ("GPG_TTY" not-in $env) { tty | str trim } else { $env.GPG_TTY }) }

export env FZF_DEFAULT_COMMAND { "fd --type file --hidden --follow" }
export env FZF_DEFAULT_OPTS {
	([
		"--cycle"
		"--bind 'alt-enter:print-query,tab:toggle-up,ctrl-y:execute-silent(echo {} | copy)'"
		"--preview 'bat --line-range :500 {}'"
	] | str collect " ")
}

##
## settings
##

export env EDITOR { "nvim" }
export env BROWSER { "google-chrome-stable" }
# export env KEYBOARD { "/dev/input/by-id/usb-Razer_Razer_BlackWidow_Ultimate-event-kbd" }
export env KEYBOARD { "/dev/input/by-id/usb-Razer_Razer_BlackWidow_Ultimate-if01-event-kbd" }

##
## apps
##

# nodejs
export env N_PREFIX { "~/local" }

# steam
export env STEAM_COMPAT_DATA_PATH { "/media/data/games/proton/" }

# godot
export env GODOT_BIN { "/usr/bin/godot" }

# sensible pagers
export env PAGER { "less -FRSX" }
export env MANPAGER { "sh -c 'col -bx | bat --language man --plain'" }

##
## path
##

export env PATH {
	(
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
			"/usr/local/bin",
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
}
