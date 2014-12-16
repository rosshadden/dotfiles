#!/usr/bin/env bash


################
# VARIABLES
################
	task=$1

	# oh-my-zsh
	export ZSH=$HOME/.oh-my-zsh
	# dots
	export DOTS=$HOME/dotfiles
	# dropbox
	export DB=$HOME/Dropbox


################
# INIT
################
	git submodule init
	git submodule update

################
# OH-MY-ZSH
################
	# install oh-my-zsh, if it is not already
	if [ ! -d $ZSH ]; then
		curl -L http://install.ohmyz.sh | sh

		# install oh-my-zsh plugins
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting

		# remove the .zshrc installed by oh-my-zsh
		rm $HOME/.zshrc
	fi

################
# SCRIPTS
################
	ln -s $DOTS/{bin,lib} $HOME/

################
# RC FILES
################
	# genenal
	ln -s $DOTS/rc/{.bashrc,.gitconfig,.gntrc,.tigrc,.tmux.conf,.vim,.zshrc} $HOME/
	# user
	ln -s $DOTS/rc/{.gitconfig} $HOME/

################
# CONFIG
################
	# general
	ln -s $DOTS/config/* $HOME/.config/
