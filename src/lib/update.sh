#!/usr/bin/env bash

pushd $DOTS

# update dotfiles
# TODO: do this if some argument is passed in
# git pull

# update submodules
thing="submodules"
echo "\nUpdating ${thing}..."
git submodule update --remote --merge
echo "Successfully updated ${thing}.\n"

# update tmux plugins
thing="tmux plugins"
echo "\nUpdating ${thing}..."
~/.tmux/plugins/tpm/bin/update_plugins all
echo "Successfully updated ${thing}.\n"

# update vim plugins
thing="vim plugins"
echo "\nUpdating ${thing}..."
./src/.vim/bundle/neobundle.vim/bin/neoinstall
echo "Successfully updated ${thing}.\n"

# sync pass
thing="pass"
echo "\nUpdating ${thing}..."
pass git pull
pass git push
echo "Successfully updated ${thing}.\n"

# sync task
thing="taskwarrior"
echo "\nUpdating ${thing}..."
task sync
echo "Successfully updated ${thing}.\n"

popd
