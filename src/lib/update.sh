#!/usr/bin/env bash

pushd $DOTS

# update dotfiles
# TODO: do this if some argument is passed in
# git pull

# update submodules
thing="submodules"
echo "Updating ${thing}..."
git submodule update --remote --merge
echo "Successfully updated ${thing}."

# update tmux plugins
thing="tmux plugins"
echo "Updating ${thing}..."
~/.tmux/plugins/tpm/bin/update_plugins all
echo "Successfully updated ${thing}."

# update vim plugins
thing="vim plugins"
echo "Updating ${thing}..."
./src/.vim/bundle/neobundle.vim/bin/neoinstall
echo "Successfully updated ${thing}."

# sync pass
thing="pass"
echo "Updating ${thing}..."
pass git pull
pass git push
echo "Successfully updated ${thing}."

# sync task
thing="taskwarrior"
echo "Updating ${thing}..."
task sync
echo "Successfully updated ${thing}."

popd
