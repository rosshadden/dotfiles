#!/usr/bin/env bash

# TODO: report whether submodules have remote changes
# TODO: report whether dotfiles have uncommitted changes
# TODO: report whether `tmux` plugins are updated
# TODO: report whether `vim` plugins are updated
# TODO: report whether `pass` is synced
# TODO: report whether `task` is synced

pushd $DOTS &> /dev/null

git fetch
git status -sb

popd &> /dev/null
