#!/usr/bin/env bash

# TODO: have params for CLI-only or X-supported (don't need to install awesomeWM on a server)

################
# INIT
################
	git submodule init
	git submodule update

################
# RC FILES
################
	# link rc files
	ln -s $DOTS/rc/{.bashrc,.gitconfig,.gntrc,.tigrc,.tmux.conf,.vim,.zshrc} $HOME/

################
# CONFIG
################
	# link configs
	ln -s $DOTS/.config/* $HOME/.config/

################
# OH-MY-ZSH
################
	# install oh-my-zsh
	curl -L http://install.ohmyz.sh | sh

	# install oh-my-zsh plugins
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
