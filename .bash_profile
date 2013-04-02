# source ~/.bashrc if it exists
if [ -f "$HOME/.bashrc" ] ; then
    . $HOME/.bashrc
fi

# load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# start screen automatically when connecting via ssh
#if [ "$TERM" != "screen" ] && [ "$SSH_CONNECTION" != "" ]; then
#    # remove "&& exit" to allow more than one ssh sessions
#    /usr/bin/screen -S sshscreen -d -R && exit
#fi
