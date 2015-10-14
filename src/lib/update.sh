#!/usr/bin/env bash

pushd $DOTS

# update dotfiles
# TODO: do this if some argument is passed in
# git pull

# update submodules
thing="submodules"
echo -e "\nUpdating ${thing}..."
git submodule update --remote --merge
echo -e "Successfully updated ${thing}.\n"

# update tmux plugins
thing="tmux plugins"
echo -e "\nUpdating ${thing}..."
~/.tmux/plugins/tpm/bin/update_plugins all
echo -e "Successfully updated ${thing}.\n"

tmux source ~/.tmux.conf
echo -e "Reloaded tmux config."

# update vim plugins
thing="vim plugins"
echo -e "\nUpdating ${thing}..."
./src/.vim/bundle/neobundle.vim/bin/neoinstall
echo -e "Successfully updated ${thing}.\n"

# sync pass
thing="pass"
echo -e "\nUpdating ${thing}..."
pass git pull
pass git push
echo -e "Successfully updated ${thing}.\n"

# sync task
thing="taskwarrior"
echo -e "\nUpdating ${thing}..."
task sync
echo -e "Successfully updated ${thing}.\n"

popd
