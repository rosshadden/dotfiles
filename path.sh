export DEFAULT_USER=$USER

export _NO_RESOLVE_SYMLINKS=true
. /home/$USER/Dropbox/.dots/z/z.sh
function precmd () {
	_z --add "$(pwd)"
}

export JAVA_HOME=/usr/lib/jvm/default-java

export ANDROID_HOME=~/media/programs/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:~/media/programs/android-sdk/platform-tools:$JAVA_HOME/bin
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64

export PATH=~/npm/bin:$PATH

export EDITOR=nano
