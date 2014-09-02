# dev
export EDITOR=vim

# PATH
export PATH=$PATH:$DOTS/bin:$HOME/local/bin:$HOME/.local/bin
[[ -e /usr/bin/ruby ]] && export PATH="`ruby -e 'puts Gem.user_dir'`/bin:$PATH"

export POWERLINE_PATH="/home/ross/.local/lib/python2.7/site-packages/powerline"

# java
export JAVA_HOME=/usr/lib/jvm/default-java

# android
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64

# misc
export DEFAULT_USER=$USER
export ATOM_REPOS_HOME=~/Dropbox/dev/forks

stty -ixon
