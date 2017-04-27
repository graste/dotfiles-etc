# source ~/.profile if it's readable
if [ -r ~/.profile ]; then
    . ~/.profile;
fi

# if we're interactive, source ~/.bashrc if it's readable
case $- in
    *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;;
      *) return;;
esac

# load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# start screen automatically when connecting via ssh
#if [ "$TERM" != "screen" ] && [ "$SSH_CONNECTION" != "" ]; then
#    # remove "&& exit" to allow more than one ssh sessions
#    /usr/bin/screen -S sshscreen -d -R && exit
#fi
