#!/usr/bin/env bash

# TODO: use the output of `dots/status.sh` to only do what's necessary

source "$DOTS/lib/shell/init/functions.sh"
source "$DOTS/lib/shell/modules/colors.sh"

haveBeenRun=""
function lawg() {
	local name=$1

	if [[ $haveBeenRun != *"[$name]"* ]]; then
		haveBeenRun+="[$name]"
		echo -e "\n${RED}Updating ${YELLOW}$name${RED}...${RESET}";
	else
		echo -e "${RED}Successfully updated ${YELLOW}$name${RED}.${RESET}\n"
	fi
}

function updateDotfiles() {
	lawg "dotfiles"
	pushd "$DOTS" > /dev/null

	# update dotfiles
	lawg "dotfiles:repo"
	git pull
	lawg "dotfiles:repo"

	# update submodules
	lawg "dotfiles:submodules"
	git submodule update --init --remote --recursive
	lawg "dotfiles:submodules"

	popd > /dev/null
	lawg "dotfiles"
}

function updateSync() {
	if [ ! -d "$SYNC" ]; then return; fi

	lawg "sync"
	pushd "$SYNC" > /dev/null

	# update sync
	lawg "sync:repo"
	git in
	lawg "sync:repo"

	# update submodules
	lawg "sync:submodules"
	git submodule update --init --remote --recursive
	lawg "sync:submodules"

	popd > /dev/null
	lawg "sync"
}

function updateTmux() {
	lawg "tmux"

	# update tmux plugins
	lawg "tmux:plugins"
	~/.tmux/plugins/tpm/bin/update_plugins all
	lawg "tmux:plugins"

	# reload tmux config
	lawg "tmux:reload"
	tmux source ~/.tmux.conf
	lawg "tmux:reload"

	lawg "tmux"
}

function updateZsh() {
	local zplugFile=$DOTS/lib/shell/zplug/init.zsh
	if [[ -f "$zplugFile" ]]; then
		lawg "zsh:plugins"
		zsh <<-eof
			source $zplugFile
			if ! zplug check --verbose; then zplug install; fi
			# zplug update
			echo "TODO: zplug doesn't work here. Run 'zplug update'"
		eof
		lawg "zsh:plugins"
	fi
}

function updateVim() {
	# update vim plugins
	if isCommand vim || isCommand nvim; then
		lawg "vim:plugins"
		$EDITOR +PlugUpdate +PlugUpgrade +qa
		lawg "vim:plugins"
	fi
}

function updatePass() {
	# sync pass
	if isCommand pass; then
		lawg "pass"
		pass git pull
		pass git push
		lawg "pass"
	fi
}

function updateTask() {
	# sync task
	if isCommand task; then
		lawg "taskwarrior"
		task sync
		lawg "taskwarrior"
	fi
}

updateDotfiles
updateSync
updateTmux
updateZsh
updateVim
updatePass
updateTask
