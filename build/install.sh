#!/usr/bin/env bash

################
# SETUP
################

task=$1

shopt -s extglob


################
# VARIABLES
################

DOTS=$HOME/dotfiles


################
# INIT
################

git submodule init
git submodule update


################
# PLUGINS
################

# oh-my-zsh
ZSH=$HOME/.oh-my-zsh
if [ ! -d $ZSH ]; then
	curl -L http://install.ohmyz.sh | sh

	# install oh-my-zsh plugins
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting

	# remove the .zshrc installed by oh-my-zsh
	rm $HOME/.zshrc
fi


################
# SYMLINKS
################

ln -s $DOTS/src/!(.config) $HOME/
ln -s $DOTS/src/.config/* $HOME/.config/


################
# CLEANUP
################

shopt -u extglob
