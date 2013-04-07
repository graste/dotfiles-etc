
PROMPT_COMMAND=setGitPrompt

function setGitPrompt()
{
    # store exit code of last command
    EXITUS=$?

    # define colors
    local n_Co=$(tput colors)
    if [[ $n_Co == 256 ]]; then
        YELLOW="\[\e[38;5;208m\]"
        BLACK="\[\e[38;5;232m\]"
        BLACKBG="\[\e[48;5;16m\]"
        GRAT="\[\e[38;5;233m\]"
        LGRAYBG="\[\e[48;5;236m\]"
        LGRAY="\[\e[38;5;236m\]"
        LLGRAY="\[\e[38;5;247m\]"
        FCYAN="\[\e[38;5;23m\]"
        GRAY="\[\e[38;5;235m\]"
        GRAYBG="\[\e[48;5;235m\]"
        GREEN="\[\e[38;5;34m\]"
        GREENBG="\[\e[48;5;34m\]"
        FGREEN="\[\e[38;5;22m\]"
        CYAN="\[\e[38;5;87m\]"
        CYANBG="\[\e[48;5;87m\]"
        RED="\[\e[38;5;196m\]"
        REDBG="\[\e[48;5;196m\]"
        WHITE="\[\e[38;5;255m\]"
        WHITEBG="\[\e[48;5;255m\]"
        UL="\[\e[4;38;5;255m\]"
        NOUL="\[\e[24;38;5;255m\]"
    else
        YELLOW="\[\e[33m\]"
        GRAY="\[\e[30m\]"
        GRAT="\[\e[30m\]"
        GREEN="\[\e[32m\]"
        BLACKBG="\[\e[0\]"
        RED="\[\e[31m\]"
        CYAN="\[\e[36m\]"
        WHITE="\[\e[37m\]"
        UL="\[\e[4m\]"
    fi

    NORM="\[\e[0m\]"
    BOLD="\[\e[1m\]"
    UNBOLD="\[\e[22m\]"

    BLUE="\[\e[34m\]"
    MAG="\[\e[35m\]"
    BG="\[\e[48;5;235m\]"

    RESETCOLOR="\[\033[0m\]"
    BGreen="\[\033[1;32m\]"       # Bold Green
    IBlack="\[\033[0;90m\]"       # High Intesity Black
    Magenta="\[\033[1;95m\]"     # Bold High Intensity Purple

    # error status code should be RED
    RETURNCODE="$EXITUS"
    if [[ $EXITUS -ne 0 ]] ; then
        RETURNCODE="$RED$BOLD$EXITUS$NORM"
    fi

    PROMPT_PREFIX="# \t \! $RETURNCODE"
    PROMPT_PATH="\w"

    # default values for git status info
    GIT_PROMPT_PREFIX="("
    GIT_PROMPT_SUFFIX=")"
    GIT_PROMPT_SEPARATOR="|"
    GIT_PROMPT_BRANCH="${Magenta}"
    GIT_PROMPT_STAGED="$RED● "
    GIT_PROMPT_CONFLICTS="$RED✖ "
    GIT_PROMPT_CHANGED="$BLUE✚ "
    GIT_PROMPT_REMOTE=" "
    GIT_PROMPT_UNTRACKED="…"
    GIT_PROMPT_CLEAN="${BGreen}✔"

    # define start and end of prompt (which is somewhat static in comparison to the git part)
    PROMPT_START="$IBlack$PROMPT_PREFIX$NORM"
    PROMPT_END=" $YELLOW$PROMPT_PATH$NORM $ "

    # get the current git working directory status information
    update_current_git_vars

    if [ -n "$__CURRENT_GIT_STATUS" ]; then
        STATUS=" $GIT_PROMPT_PREFIX$GIT_PROMPT_BRANCH$GIT_BRANCH$NORM"

        if [ -n "$GIT_REMOTE" ]; then
            STATUS="$STATUS$GIT_PROMPT_REMOTE$GIT_REMOTE$NORM"
        fi

        STATUS="$STATUS$GIT_PROMPT_SEPARATOR"
        if [ "$GIT_STAGED" -ne "0" ]; then
            STATUS="$STATUS$GIT_PROMPT_STAGED$GIT_STAGED$NORM"
        fi

        if [ "$GIT_CONFLICTS" -ne "0" ]; then
            STATUS="$STATUS$GIT_PROMPT_CONFLICTS$GIT_CONFLICTS$NORM"
        fi

        if [ "$GIT_CHANGED" -ne "0" ]; then
            STATUS="$STATUS$GIT_PROMPT_CHANGED$GIT_CHANGED$NORM"
        fi

        if [ "$GIT_UNTRACKED" -ne "0" ]; then
            STATUS="$STATUS$GIT_PROMPT_UNTRACKED$GIT_UNTRACKED$NORM"
        fi

        if [ "$GIT_CLEAN" -eq "1" ]; then
            STATUS="$STATUS$GIT_PROMPT_CLEAN"
        fi

        STATUS="$STATUS$NORM$GIT_PROMPT_SUFFIX"

        # prompt for git directories
        PS1="$PROMPT_START$STATUS$PROMPT_END"
    else
        # default prompt in non-git directories
        PS1="$PROMPT_START$PROMPT_END"
    fi
}


function update_current_git_vars()
{
    unset __CURRENT_GIT_STATUS
    local gitstatus="$HOME/.bash/gitstatus.py"

    _GIT_STATUS=$(python $gitstatus)
    __CURRENT_GIT_STATUS=($_GIT_STATUS)
    GIT_BRANCH=${__CURRENT_GIT_STATUS[0]}
    GIT_REMOTE=${__CURRENT_GIT_STATUS[1]}
    if [[ "." == "$GIT_REMOTE" ]]; then
        unset GIT_REMOTE
    fi
    GIT_STAGED=${__CURRENT_GIT_STATUS[2]}
    GIT_CONFLICTS=${__CURRENT_GIT_STATUS[3]}
    GIT_CHANGED=${__CURRENT_GIT_STATUS[4]}
    GIT_UNTRACKED=${__CURRENT_GIT_STATUS[5]}
    GIT_CLEAN=${__CURRENT_GIT_STATUS[6]}
}

# vim: set ts=4 sw=4 tw=0 et :
