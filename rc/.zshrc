################
# VARIABLES
################
	# oh-my-zsh
	export ZSH=$HOME/.oh-my-zsh
	# dots
	export DOTS=$HOME/dotfiles
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
	# source $DOTS/shell/env.sh
	source $DOTS/shell/alias.sh
	source $DOTS/shell/general.sh
	source $DOTS/shell/functions.sh
	[[ -e "$HOME/.local.sh" ]] && source $HOME/.local.sh


################
# THEME
################
	source $DOTS/themes/shell.sh


################
# PLUGINS
################
	plugins=(battery extract git-extras node npm python nyan sublime vi-mode history-substring-search tmux systemd zsh-syntax-highlighting fasd)

	# source $ZSH/oh-my-zsh.sh
	source $HOME/.oh-my-zsh/oh-my-zsh.sh
	source $DOTS/shell/plugins/vim.zsh
	source $DOTS/shell/plugins/tmuxinator.zsh
	source $DOTS/shell/plugins/opp.zsh/opp.zsh
	source $DOTS/shell/plugins/opp.zsh/opp/*.zsh
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
		[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
		[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
		[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
		[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
		[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
		[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
		[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
		[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
		[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

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


################
# PROGRAMS
################
	# Colored MAN pages
	man() {
		env LESS_TERMCAP_mb=$'\E[01;31m' \
		LESS_TERMCAP_md=$'\E[01;38;5;74m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_se=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[38;5;246m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[04;38;5;146m' \
		man "$@"
	}
