# append to the history file, don't overwrite it (on exit)
shopt -s histappend

# multi-line commands will be appended to history as a single-line command
shopt -s cmdhist

# must use ">|filename" to force overwriting (prevents output redirection using ">", ">&" and "<>" from overwriting existing files)
shopt -o noclobber

# enable filename expansion (use "set -f" to disable globbing)
set +o noglob

# allow "." files to be returned when pathnames are expanded
shopt -s dotglob

# activate extended pattern matching features
# ?(pattern-list) 
#   Matches zero or one occurrence of the given patterns 
# *(pattern-list) 
#   Matches zero or more occurrences of the given patterns 
# +(pattern-list) 
#   Matches one or more occurrences of the given patterns 
# @(pattern-list) 
#   Matches exactly one of the given patterns 
# !(pattern-list) 
#   Matches anything except one of the given patterns
shopt -s extglob

# use "**" to match all files and zero or more directories and subdirectories in a pathname expansion context
shopt -s globstar

# correct simple directory misspellings when using "cd"
shopt -s cdspell

# will automatically cd if only a directory is given
shopt -s autocd

# will let you cd into a variable: foo="/tmp";$foo
shopt -s cdable_vars

# check the window size after each command and update the values of LINES and COLUMNS if necessary
shopt -s checkwinsize

# get immediate notification of background job termination instead of before next primary prompt
#set -o notify

# do not exit upon EOF - disables [CTRL-D] to exit the shell
set -o ignoreeof

# exit immediately when command in pipeline fails - exit code of piped commands will be the exit code of the failed command ("set +e" to disable)
set -o errexit

# expand braces ("set -B")
set -o braceexpand

# enable history (enabled by default for interactive shells)
set -o history

# enable "!" history substitution (on by default for interactive shells; use "set +H" to disable)
set -o histexpand

# job monitoring (enabled by default for interactive shells; use "set +m" to disable)
set -o monitor

