# we want vim as default editor
export EDITOR=vim
export VISUAL=vim

# trim paths to 3 hierarchy levels
export PROMPT_DIRTRIM=3

# must press ctrl-D 2+1 times to exit shell
export IGNOREEOF="2"

# ignore case, long prompt, exit if it fits on one screen
export LESS="-iMFXR"

#export GREP_OPTIONS='--color=auto'

# base paths to use for "cd" command completion                                                                                                   
#export CDPATH=.:~:/mnt:/media:/etc

# PATHs for command lookup
export PATH=~/bin:/opt/vagrant/bin:$PATH

# enable vagrant debug logs
#export VAGRANT_LOG=debug
