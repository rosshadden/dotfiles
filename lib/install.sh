#!/usr/bin/env bash

# TODO: have params for CLI-only or X-supported (don't need to install awesomeWM on a server)
# TODO: make all these location-agnostic (don't assume ~/dotfiles)

################
# INIT
################
git submodule init
git submodule update

################
# RC FILES
################
# link rc files
ln -s ~/dotfiles/rc/{.bashrc,.gitconfig,.gntrc,.tigrc,.tmux.conf,.vimrc,.zshrc} ~/

################
# CONFIG
################
# link configs
ln -s ~/dotfiles/.config/* ~/.config/

################
# OH-MY-ZSH
################
# install oh-my-zsh
curl -L http://install.ohmyz.sh | sh
# install oh-my-zsh theme
ln -s ~/dotfiles/themes/ross.zsh-theme ~/.oh-my-zsh/themes/
# install oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

