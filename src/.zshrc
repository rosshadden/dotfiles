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

	# TODO: group into object
	shellDir=$DOTS/lib/shell
	initDir=$shellDir/init
	moduleDir=$shellDir/modules
	pluginDir=$shellDir/plugins
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

function packages() {
	source $shellDir/zplug/init.zsh

	zplug lib/history, from:oh-my-zsh
	zplug plugins/git-extras, from:oh-my-zsh
	zplug plugins/systemd, from:oh-my-zsh

	zplug Tarrasch/zsh-bd
	zplug Tarrasch/zsh-functional
	zplug zsh-users/zsh-syntax-highlighting
	zplug zsh-users/zsh-history-substring-search

	if ! zplug check --verbose; then zplug install; fi
	zplug load
}

function modules() {
	for plugin in $pluginDir/*.zsh; do sourceIfExists $plugin; done
	for module in $initDir/{functions,env}.sh $moduleDir/*.{,z}sh; do sourceIfExists $module; done

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
