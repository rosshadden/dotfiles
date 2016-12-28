if [ $commands[fasd] ]; then
	fasd_cache="$XDG_CACHE_HOME/fasd-init"
	if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
		fasd --init auto >| "$fasd_cache"
	fi
	source "$fasd_cache"
	unset fasd_cache

	alias v="f -t -e $EDITOR -b viminfo"
	if [ $commands[nvim] ]; then alias v="nfasd -e nvim"; fi
	alias o="a -e open_command"
	alias j="fasd_cd -d"
	alias jj="fasd_cd -d -i"
fi

autoload bashcompinit
bashcompinit
eval "$(register-python-argcomplete nfasd)"
