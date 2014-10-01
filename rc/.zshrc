################
# VARIABLES
################
	# dots
	export DOTS=$HOME/dotfiles
	# oh-my-zsh
	export ZSH=$HOME/.oh-my-zsh
	# dropbox
	export DB=$HOME/Dropbox


################
# OPTIONS
################
	ZSH_THEME="agnoster"

	# use case-sensitive completion
	# CASE_SENSITIVE="true"

	# auto-update checks
	# DISABLE_AUTO_UPDATE="true"

	# disable colors in ls
	# DISABLE_LS_COLORS="true"

	# disable autosetting terminal title.
	# DISABLE_AUTO_TITLE="true"

	# red dots displayed while waiting for completion
	COMPLETION_WAITING_DOTS="true"


################
# MODULES
################
	. $DOTS/shell/env.sh
	. $DOTS/shell/alias.sh
	. $DOTS/shell/general.sh
	. $DOTS/shell/functions.sh
	[[ -e "$HOME/.local.sh" ]] && . $HOME/.local.sh


################
# THEME
################
	. $DOTS/themes/shell.sh


################
# PLUGINS
################
	plugins=(battery extract git-extras node npm python nyan sublime vi-mode history-substring-search systemd zsh-syntax-highlighting fasd)

	. $ZSH/oh-my-zsh.sh
	. $DOTS/shell/plugins/vim.zsh
	. $DOTS/shell/plugins/tmuxinator.zsh
	. $DOTS/shell/plugins/opp.zsh/opp.zsh
	. $DOTS/shell/plugins/opp.zsh/opp/*.zsh
	unsetopt correct_all


################
# TERMINAL
################
	# fix shift-tab in completion menus
	bindkey '^[[Z' reverse-menu-complete

	# Make special keys work
		# create a zkbd compatible hash;
		# to add other keys to this hash, see: man 5 terminfo
		typeset -A key

		key[Home]=${terminfo[khome]}
		key[End]=${terminfo[kend]}
		key[Insert]=${terminfo[kich1]}
		key[Delete]=${terminfo[kdch1]}
		key[Up]=${terminfo[kcuu1]}
		key[Down]=${terminfo[kcud1]}
		key[Left]=${terminfo[kcub1]}
		key[Right]=${terminfo[kcuf1]}
		key[PageUp]=${terminfo[kpp]}
		key[PageDown]=${terminfo[knp]}

		# setup key accordingly
		if [[ -n "${key[End]}"      ]]; then bindkey  "${key[End]}"      end-of-line; fi
		if [[ -n "${key[Insert]}"   ]]; then bindkey  "${key[Insert]}"   overwrite-mode; fi
		if [[ -n "${key[Delete]}"   ]]; then bindkey  "${key[Delete]}"   delete-char; fi
		if [[ -n "${key[Up]}"       ]]; then bindkey  "${key[Up]}"       up-line-or-history; fi
		if [[ -n "${key[Down]}"     ]]; then bindkey  "${key[Down]}"     down-line-or-history; fi
		if [[ -n "${key[Left]}"     ]]; then bindkey  "${key[Left]}"     backward-char; fi
		if [[ -n "${key[Right]}"    ]]; then bindkey  "${key[Right]}"    forward-char; fi
		if [[ -n "${key[PageUp]}"   ]]; then bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history; fi
		if [[ -n "${key[PageDown]}" ]]; then bindkey  "${key[PageDown]}" end-of-buffer-or-history; fi

		# Finally, make sure the terminal is in application mode, when zle is active.
		# Only then are the values from $terminfo valid.
		if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
			function zle-line-init () {
				printf '%s' "${terminfo[smkx]}"
			}
			function zle-line-finish () {
				printf '%s' "${terminfo[rmkx]}"
			}
			zle -N zle-line-init
			zle -N zle-line-finish
		fi

	# vi-mode
		KEYTIMEOUT=1

		bindkey -M vicmd '' redo
		bindkey -M viins 'R' history-incremental-pattern-search-backward
		bindkey -M vicmd 'R' history-incremental-pattern-search-backward
		bindkey -M vicmd ' ' vi-forward-char

	# Fish-like syntax highlighting
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
	ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=red'

	# expand .[TAB] and ..[TAB]
	zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

	# colors
	# Base16 Shell
	# BASE16_SCHEME="default"
	# BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
	# [[ -s $BASE16_SHELL ]] && . $BASE16_SHELL
