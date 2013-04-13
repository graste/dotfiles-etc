# don't put duplicate lines in the history or force ignoredups and ignorespace
export HISTCONTROL=ignoredups:ignorespace:erasedups

# history buffer length
export HISTSIZE=5000

# history file length
export HISTFILESIZE=10000

# blacklist some sensitive history entries here if necessary (":" as separator)
#export HISTIGNORE="&:[ ]*:truecrypt -P*:sudo*"
export HISTIGNORE="&:[ ]*:ls:ll:la:[bf]g:exit:truecrypt -P*"

# append to the history file, don't overwrite it
shopt -s histappend

# multi-line commands will be appended to history as a single-line command
shopt -s cmdhist

# enable history (enabled by default for interactive shells)
set -o history
