#
# ~/.bashrc: executed by bash(1) for non-login shells.
#

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# another attempt at not doing anything if not running interactively
[ -z "$PS1" ] && return

# source system wide bash settings
if [ -f "/etc/bashrc" ] ; then
    . /etc/bashrc
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

# default prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# if this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and grep via aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# 


# timeout bash after N seconds if current user is root
if [ $(id -u) = 0 ] ; then 
    export TMOUT=120
fi

# settings for local or remote logins
if [ -z "$SSH_CLIENT" ]; then
    # code when local login
    echo "Local login..."
else
    # code when remote login
    echo "Remote login..."
fi

export USE_GIT_IN_PROMPT=no

# source function definitions
if [ -d "${HOME}/.bash" ]; then
    . ${HOME}/.bash/environment.sh
    . ${HOME}/.bash/functions.sh
    . ${HOME}/.bash/git.sh
    . ${HOME}/.bash/gitprompt.sh
    . ${HOME}/.bash/options.sh
    . ${HOME}/.bash/history.sh # this should stay last
else
    printf '~/.bash directory not found. Not sourcing any files.\n'
fi

# source alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
else
    printf '~/.bash_aliases not found. Not sourcing alias definitions.\n'
fi

# source some local bash completions
if [[ -d "${HOME}/.bash/completions" && -r "${HOME}/.bash/completions" && -x "${HOME}/.bash/completions" ]]; then
    for i in $(LC_ALL=C command ls "${HOME}/.bash/completions"); do
        i="${HOME}/.bash/completions"/$i
        [[ ${i##*/} != @(*~|*.bak|*.swp|\#*\#|*.dpkg*|*.rpm@(orig|new|save)|Makefile*) && -f $i && -r $i ]] && . "$i"
    done
fi
unset i

# howto: find the actual current folder
#SOURCE="${BASH_SOURCE[0]}"
#while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
#  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
#  SOURCE="$(readlink "$SOURCE")"
#  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
#done
#DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

PATH=$PATH:~/bin

# npm global install in user home dir
export NPM_CONFIG_PREFIX=~/.npm-global
PATH=$PATH:~/.npm-global/bin

# vulnerable to shellshock? http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2014-6271
env x='() { :;}; echo "WARNING: SHELLSHOCK DETECTED"' bash --norc -c ':' 2>/dev/null;

