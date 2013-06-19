export DEFAULT_USER=$USER

export _NO_RESOLVE_SYMLINKS=true
. /home/$USER/Dropbox/.dots/z/z.sh
function precmd () {
	_z --add "$(pwd)"
}

# export JAVA_HOME=/usr/lib/jvm/java-7-oracle
# export JAVA_HOME=/usr/lib/jvm/java-6-oracle
# export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
# export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

export PATH=$PATH:~/media/programs/android-sdk/tools:~/media/programs/android-sdk/platform-tools:$JAVA_HOME/bin
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64

export PATH=$PATH:/usr/local/cuda/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib:/usr/local/cuda/lib64
echo 'export PATH=$PATH:/usr/local/cuda/bin' >> ~/.bash_profile
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib:/usr/local/cuda/lib64' >> ~/.bash_profile

export EDITOR=nano
