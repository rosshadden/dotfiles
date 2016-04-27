#!/usr/bin/env zsh

# TODO: use the output of `dots/status.sh` to only do what's necessary
# TODO: port to bash

# TODO: fix broken refs from sourcing this file
source ~/dotfiles/src/shell/features.zsh

################
# FUNCTIONS
################

haveBeenRun=()
lawg() {
	local name=$1

	if [[ ${haveBeenRun[(i)$name]} -gt ${#haveBeenRun} ]]; then
		haveBeenRun+=( $name )
		echo -e "\n${RED}Updating ${YELLOW}$name${RED}...${RESET}";
	else
		echo -e "${RED}Successfully updated ${YELLOW}$name${RED}.${RESET}\n"
	fi
}

################
# DEBUG
################

if [[ "$1" == "debug" ]]; then
	lawg "debug"
	lawg "debug"

	lawg "debug:two"
	lawg "debug:two"

	exit 0
fi

################
# DOTFILES
################

lawg "dotfiles"
pushd $DOTS

# update dotfiles
lawg "dotfiles:repo"
git pull
lawg "dotfiles:repo"

# update submodules
lawg "dotfiles:submodules"
git submodule update --init --remote --merge --recursive
lawg "dotfiles:submodules"

popd
lawg "dotfiles"

################
# SYNC
################

lawg "sync"
pushd $SYNC

# update sync
lawg "sync:repo"
git in
lawg "sync:repo"

# update submodules
lawg "sync:submodules"
git submodule update --init --remote --recursive
lawg "sync:submodules"

popd
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
# ~/.vim/bundle/neobundle.vim/bin/neoinstall
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
