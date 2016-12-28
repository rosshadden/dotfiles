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

	zplug lib/completion, from:oh-my-zsh
	zplug lib/history, from:oh-my-zsh
	zplug plugins/git-extras, from:oh-my-zsh
	zplug plugins/systemd, from:oh-my-zsh

	zplug Tarrasch/zsh-bd
	zplug Tarrasch/zsh-functional
	zplug trapd00r/LS_COLORS
	zplug zsh-users/zsh-history-substring-search
	zplug zsh-users/zsh-syntax-highlighting

	if ! zplug check --verbose; then zplug install; fi
	zplug load
}

function modules() {
	local shellDir=$DOTS/lib/shell
	for plugin in $shellDir/plugins/*.zsh; do sourceIfExists $plugin; done
	for module in $shellDir/init/{functions,env}.sh $shellDir/modules/*.{,z}sh; do sourceIfExists $module; done

	sourceIfExists ~/local/.sh
	sourceIfExists ~/local/.zshrc
}

function() {
	local fns=( variables options packages modules )

	# run and cleanup functions
	for fn in $fns; do
		$fn
		unfunction $fn
	done
}
