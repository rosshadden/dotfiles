# TODO: handle n args
function sourceIfExists() {
	if [[ -f "$1" ]]; then source "$1"; fi
}

function variables() {
	# XDG
	export XDG_CONFIG_HOME=$HOME/.config
	export XDG_CACHE_HOME=$HOME/.cache
	export XDG_DATA_HOME=$HOME/.local/share

	# apps
	export DOTS=$HOME/dotfiles
	export SYNC=$HOME/sync
	export DB=$HOME/Dropbox
}

function options() {
	# command correction
	setopt correct

	# don't share history
	setopt nosharehistory

	setopt auto_pushd
	setopt pushd_ignore_dups

	# dots displayed while waiting for completion
	# COMPLETION_WAITING_DOTS="true"

	# better zsh correction prompt
	SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? ([y]es, [n]o, [a]bort, [e]dit) "
}

function packages() {
	local shellDir=$DOTS/lib/shell
	source $shellDir/zplug/init.zsh

	zplug "Aloxaf/fzf-tab"
	zplug "Tarrasch/zsh-bd"
	zplug "Tarrasch/zsh-functional"
	zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
	zplug "trapd00r/LS_COLORS"
	zplug "zsh-users/zsh-history-substring-search"
	zplug "zsh-users/zsh-syntax-highlighting"

	if ! zplug check --verbose; then zplug install; fi
	zplug load
}

function modules() {
	local shellDir=$DOTS/lib/shell
	for file in $shellDir/init/{functions,env}.sh; do sourceIfExists $file; done
	for file in $shellDir/plugins/*.zsh; do sourceIfExists $file; done
	for file in $shellDir/modules/*.{,z}sh; do sourceIfExists $file; done
	for file in ~/local/.sh ~/local/.zshrc; do sourceIfExists $file; done
}

function() {
	local fns=( variables options packages modules )

	# run and cleanup functions
	for fn in $fns; do
		$fn
		unfunction $fn
	done
}
