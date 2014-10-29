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
	# command correction
	setopt correct


################
# CONFIG
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

	# better zsh correction prompt
	SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? ([y]es, [n]o, [a]bort, [e]dit) "


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
	# base16 colors
	. $DOTS/themes/shell.sh
	if [ "${TERM%%-*}" = 'linux' ]; then
		BASE16_SHELL="$DOTS/themes/vconsole.sh"
	else
		BASE16_SCHEME="summerfruit"
		BASE16_VARIANT="dark"
		BASE16_SHELL="$DOTS/themes/base16-shell/base16-$BASE16_SCHEME.$BASE16_VARIANT.sh"
	fi
	[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

	# airline prompt
	. $DOTS/themes/promptline.sh


################
# PLUGINS
################
	plugins=(battery extract git-extras node npm python nyan vi-mode history-substring-search systemd zsh-syntax-highlighting fasd)

	. $ZSH/oh-my-zsh.sh
	. $DOTS/shell/plugins/vim.zsh
	. $DOTS/shell/plugins/tmuxinator.zsh
	. $DOTS/shell/plugins/opp.zsh/opp.zsh
	. $DOTS/shell/plugins/opp.zsh/opp/*.zsh


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

	# enhanced <m-.> and <m-m> argument completion
	# http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
	autoload -Uz copy-earlier-word
	zle -N copy-earlier-word
	bindkey "^[m" copy-earlier-word

	# vi-mode
		KEYTIMEOUT=1

		# redo
		bindkey -M vicmd 'U' redo
		# history substring searching
		bindkey -M viins 'R' history-incremental-pattern-search-backward
		bindkey -M vicmd 'R' history-incremental-pattern-search-backward
		# default <space> is pretty frustrating when I bump it
		bindkey -M vicmd ' ' vi-forward-char
		# <space> to expand history expansion
		bindkey ' ' magic-space

	# enhanced <c-r>
	# http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
	autoload -Uz narrow-to-region
	function _history-incremental-preserving-pattern-search-backward {
		local state
		MARK=CURSOR  # magick, else multiple ^R don't work
		narrow-to-region -p "$LBUFFER${BUFFER:+>>}" -P "${BUFFER:+<<}$RBUFFER" -S state
		zle end-of-history
		zle history-incremental-pattern-search-backward
		narrow-to-region -R state
	}
	zle -N _history-incremental-preserving-pattern-search-backward
	bindkey "^R" _history-incremental-preserving-pattern-search-backward
	bindkey -M isearch "^R" history-incremental-pattern-search-backward
	bindkey "^S" history-incremental-pattern-search-forward

	# Fish-like syntax highlighting
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
	ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=red'

	# expand .[TAB] and ..[TAB]
	zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
