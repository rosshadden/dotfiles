#!/usr/bin/env bash

pushd $DOTS

# update dotfiles
# TODO: do this if some argument is passed in
# git pull

# update submodules
git submodule update --remote --merge

# update tmux plugins
~/.tmux/plugins/tpm/bin/update_plugins all

# update vim plugins
./src/.vim/bundle/neobundle.vim/bin/neoinstall

# sync pass
pass git pull
pass git push

# sync task
task sync

popd
