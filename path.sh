export DEFAULT_USER=$USER

export _NO_RESOLVE_SYMLINKS=true
. $DOTS/z/z.sh
function precmd () {
	_z --add "$(pwd)"
}

export JAVA_HOME=/usr/lib/jvm/default-java

export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64

export PATH=$PATH:~/pear/bin
export PATH=$PATH:$HOME/local/bin
[[ -e /usr/bin/ruby ]] && export PATH="`ruby -e 'puts Gem.user_dir'`/bin:$PATH"

export EDITOR=vim

stty -ixon
