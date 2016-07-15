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
	utilDir=$shellDir/utils
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

function modules() {
	for util in $utilDir/*; do source $util; done
	for module in $moduleDir/*; do source $module; done
	for plugin in $pluginDir/*; do source $plugin; done

	[[ -f ~/local/.zshrc ]] && source ~/local/.zshrc
}

function() {
	local fns=( variables options packages modules )

	# run and cleanup functions
	for fn in $fns; do
		$fn
		unfunction $fn
	done
}
