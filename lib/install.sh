#!/usr/bin/env bash

# TODO: have params for CLI-only or X-supported (don't need to install i3 on a server)
# TODO: make a cleanup process
# TODO: possibly make a (generated?) manifest file, to make cleanup easier
# TODO: break variables out, since I currently have to use them both here and in .zshrc
# TODO: support anonymous installs, where things like .gitconfig wouldn't be installed
# TODO: vet [http://www.gnu.org/software/stow/](GNU stow) as a symlink organization tool

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
