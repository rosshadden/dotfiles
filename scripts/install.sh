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
# SYMLINKS
################

ln -s $DOTS/src/!(.config) $HOME/
ln -s $DOTS/src/.config/* $HOME/.config/

################
# CLEANUP
################

shopt -u extglob
