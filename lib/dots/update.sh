#!/usr/bin/env bash

# TODO: use the output of `dots/status.sh` to only do what's necessary

################
# INIT
################

source "$(dirname $0)/functions.sh"
source "$DOTS/lib/shell/modules/colors.sh"

################
# FUNCTIONS
################

haveBeenRun=""
lawg() {
	local name=$1

	if [[ $haveBeenRun != *"[$name]"* ]]; then
		haveBeenRun+="[$name]"
		echo -e "\n${RED}Updating ${YELLOW}$name${RED}...${RESET}";
	else
		echo -e "${RED}Successfully updated ${YELLOW}$name${RED}.${RESET}\n"
	fi
}

################
# DOTFILES
################

lawg "dotfiles"
pushd $DOTS > /dev/null

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

################
# SYNC
################

lawg "sync"
pushd $SYNC > /dev/null

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

################
# TMUX
################

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

################
# VIM
################

# update vim plugins
lawg "vim:plugins"
nvim +PlugUpdate +PlugUpgrade +qa
lawg "vim:plugins"

################
# PASS
################

# sync pass
lawg "pass"
pass git pull
pass git push
lawg "pass"

################
# TASKWARRIOR
################

# sync task
lawg "taskwarrior"
task sync
lawg "taskwarrior"
