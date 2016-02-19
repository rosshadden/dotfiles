function variables() {
	# XDG
	export XDG_CONFIG_HOME=$HOME/.config
	export XDG_CACHE_HOME=$HOME/.cache
	export XDG_DATA_HOME=$HOME/.local/share

	# dots
	export DOTS=$HOME/dotfiles
	# sync
	export SYNC=$HOME/sync
	# dropbox
	export DB=$HOME/Dropbox

	# shell dir
	shellDir=$DOTS/src/shell
	# themes dir
	themeDir=$DOTS/src/themes
}

function options() {
	# command correction
	setopt correct

	# dots displayed while waiting for completion
	# COMPLETION_WAITING_DOTS="true"

	# better zsh correction prompt
	SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? ([y]es, [n]o, [a]bort, [e]dit) "
}

function packages() {
	source $shellDir/antibody/antibody.zsh
	source $shellDir/antigen/antigen.zsh

	antigen use oh-my-zsh

	antigen bundle extract
	antigen bundle git-extras
	antigen bundle systemd

	antigen apply

	antibody bundle Tarrasch/zsh-bd
	antibody bundle Tarrasch/zsh-functional
	antibody bundle zsh-users/zsh-history-substring-search
	antibody bundle zsh-users/zsh-syntax-highlighting
}

function modules() {
	autoload -U compaudit compinit

	source $shellDir/env.sh
	source $shellDir/colors.sh
	source $shellDir/functions.sh
	source $shellDir/alias.sh
	source $shellDir/general.sh
	[[ -f ~/local/.zshrc ]] && source ~/local/.zshrc
}

function features() {
	source $shellDir/features.zsh
}

function plugins() {
	source $shellDir/plugins/vim.zsh

	# tmuxp
	source tmuxp.zsh

	# npm
	source <(npm completion)

	# zsh-syntax-highlighting
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
	ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=red'

	# TODO: move to standalone file, merged with shell/plugins/vim.zsh
	# expand
	bindkey '^f' vi-forward-blank-word
	bindkey '^[f' vi-forward-char
	bindkey '^b' vi-backward-blank-word
	bindkey '^[b' vi-backward-char

	# fasd
	# TODO: move back to a place shared with bash
	if [ $commands[fasd] ]; then # check if fasd is installed
		fasd_cache="$XDG_CACHE_HOME/fasd-init"
		if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
			fasd --init auto >| "$fasd_cache"
		fi
		source "$fasd_cache"
		unset fasd_cache

		alias v='f -t -e vim -b viminfo'
		alias o='a -e open_command'
		alias j="fasd_cd -d"
		alias jj="fasd_cd -d -i"
	fi
}

function mappings() {
	# fix shift-tab in completion menus
	bindkey -a '	' menu-expand-or-complete

	# fix shift-tab in completion menus
	bindkey '^[[Z' reverse-menu-complete

	# copy yank register to X clipboard
	vi-yank-to-x() { print -rn -- $CUTBUFFER | xsel -ib -p; }
	zle -N vi-yank-to-x
	bindkey -a '^Y' vi-yank-to-x
}

function theme() {
	# NOTE: overwritten below
	ZSH_THEME="agnoster"


	# base16 colors
	if [ "${TERM%%-*}" = 'linux' ]; then
		BASE16_TYPE="vconsole"
	else
		BASE16_TYPE="shell"
	fi

	THEME="pop"
	BASE16_VARIANT="dark"
	BASE16_DIR="$themeDir/base16-builder/output/$BASE16_TYPE"
	BASE16_SHELL="$BASE16_DIR/base16-$THEME.$BASE16_VARIANT.sh"

	[[ -f $BASE16_SHELL ]] && source $BASE16_SHELL


	# airline prompt
	source $themeDir/promptline.sh
}

function terminal() {
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


	# VI-MODE
	# TODO: breakout.exe

	vim_ins_mode="INSERT"
	vim_cmd_mode="NORMAL"
	vim_mode=$vim_ins_mode

	zle-keymap-select() {
		vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
		__promptline
		zle reset-prompt

		if [ "$TERM" != "linux" ]; then
			if [ $KEYMAP = vicmd ]; then
				set-prompt $colors[normal2] 2
			else
				set-prompt $colors[insert2] 2
			fi
		fi
	};
	zle -N zle-keymap-select

	function zle-line-finish {
		vim_mode=$vim_ins_mode
	}
	zle -N zle-line-finish

	function TRAPINT() {
		vim_mode=$vim_ins_mode
		return $(( 128 + $1 ))
	}

	# allow termite to open new windows in pwd
	if [[ $TERM == xterm-termite ]]; then
		source /etc/profile.d/vte.sh
		__vte_osc7
	fi


	# INIT

	zle-line-init () {
		# RESET
		zle -K viins
		set-prompt $colors[insert2] 2

		# Enable autosuggestions automatically
		# zle autosuggest-start
	};
	zle -N zle-line-init
}

fns=( variables options packages modules features plugins mappings theme terminal )

function load() {
	for fn in $fns; do $fn; done
}

function cleanup() {
	for fn in $fns; do unfunction $fn; done
}

function() {
	load

	cleanup
}
