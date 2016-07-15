function variables() {
	# XDG
	export XDG_CONFIG_HOME=$HOME/.config
	export XDG_CACHE_HOME=$HOME/.cache
	export XDG_DATA_HOME=$HOME/.local/share

	# apps
	export DOTS=$HOME/dotfiles
	export SYNC=$HOME/sync
	export DB=$HOME/Dropbox

	shellDir=$DOTS/lib/shell
	moduleDir=$shellDir/modules
	pluginDir=$shellDir/plugins
}

function packages() {
	source $shellDir/antibody/antibody.zsh
	source $shellDir/antigen/antigen.zsh

	antigen use oh-my-zsh

	antigen bundle extract
	antigen bundle git
	antigen bundle git-extras
	antigen bundle systemd

	antigen apply

	antibody bundle Tarrasch/zsh-bd
	antibody bundle Tarrasch/zsh-functional
	antibody bundle zsh-users/zsh-history-substring-search
	antibody bundle zsh-users/zsh-syntax-highlighting
}

function options() {
	# command correction
	setopt correct

	# don't share history
	setopt nosharehistory

	# dots displayed while waiting for completion
	# COMPLETION_WAITING_DOTS="true"

	# better zsh correction prompt
	SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? ([y]es, [n]o, [a]bort, [e]dit) "
}

function modules() {
	autoload -U compaudit compinit

	source $moduleDir/functions.sh
	source $moduleDir/env.sh
	source $moduleDir/colors.sh
	source $moduleDir/alias.sh
	source $moduleDir/general.sh
	source $moduleDir/theme.zsh
	source $moduleDir/features.zsh
	[[ -f ~/local/.zshrc ]] && source ~/local/.zshrc
}

function plugins() {
	for plugin in $pluginDir/*; do
		source $plugin
	done
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

	# load `fzf` mappings
	local shell="$(getShell)"
	if [[ -f /usr/share/fzf/key-bindings.$shell ]]; then local fzfMappings=/usr/share/fzf/key-bindings.$shell; fi
	if [[ -f /etc/profile.d/fzf.$shell ]]; then local fzfMappings=/etc/profile.d/fzf.$shell; fi
	if [[ "$fzfMappings" != "" ]]; then source $fzfMappings; fi
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
			function zle-line-init () { printf '%s' "${terminfo[smkx]}" }
			function zle-line-finish () { printf '%s' "${terminfo[rmkx]}" }
			zle -N zle-line-init
			zle -N zle-line-finish
		fi

	# allow termite to open new windows in pwd
	if [[ $TERM == xterm-termite ]]; then
		source /etc/profile.d/vte.sh
		__vte_osc7
	fi
}

fns=( variables packages options modules plugins mappings terminal )

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
