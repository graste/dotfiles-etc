
PROMPT_COMMAND=setGitPrompt

function setGitPrompt()
{
    # store exit code of last command
    EXITUS=$?

    # define colors
    local n_Co=$(tput colors)
    if [[ $n_Co == 256 ]]; then
        YELLOW="\[\033[38;5;208m\]"
        BLACK="\[\033[38;5;232m\]"
        BLACKBG="\[\033[48;5;16m\]"
        GRAT="\[\033[38;5;233m\]"
        LGRAYBG="\[\033[48;5;236m\]"
        LGRAY="\[\033[38;5;236m\]"
        LLGRAY="\[\033[38;5;247m\]"
        FCYAN="\[\033[38;5;23m\]"
        GRAY="\[\033[38;5;235m\]"
        GRAYBG="\[\033[48;5;235m\]"
        GREEN="\[\033[38;5;34m\]"
        GREENBG="\[\033[48;5;34m\]"
        FGREEN="\[\033[38;5;22m\]"
        CYAN="\[\033[38;5;87m\]"
        CYANBG="\[\033[48;5;87m\]"
        RED="\[\033[38;5;196m\]"
        REDBG="\[\033[48;5;196m\]"
        WHITE="\[\033[38;5;255m\]"
        WHITEBG="\[\033[48;5;255m\]"
        UL="\[\033[4;38;5;255m\]"
        NOUL="\[\033[24;38;5;255m\]"
    else
        BLACKBG="\[\033[0\]"
        GRAY="\[\033[30m\]"
        RED="\[\033[31m\]"
        GREEN="\[\033[32m\]"
        YELLOW="\[\033[33m\]"
        BLUE="\[\033[34m\]"
        MAGENTA="\[\033[35m\]"
        CYAN="\[\033[36m\]"
        WHITE="\[\033[37m\]"
        UL="\[\033[4m\]"
    fi

    RESETCOLOR="\[\033[0m\]"
    NORM="\[\033[0m\]"
    BOLD="\[\033[1m\]"
    UNBOLD="\[\033[22m\]"

    BG="\[\033[48;5;235m\]"

    BGREEN="\[\033[1;32m\]" # Bold Green
    IBLACK="\[\033[0;90m\]" # High Intensity Black
    BIMAGENTA="\[\033[1;95m\]" # Bold High Intensity Purple

    # error status code should be RED
    RETURNCODE="$EXITUS"
    if [[ $EXITUS -ne 0 ]] ; then
        RETURNCODE="$RED$BOLD$EXITUS$NORM"
    fi

    # comment, time, history id, last command's exit code
    PROMPT_PREFIX="# \t \! $RETURNCODE"

    # current working directory in colors
    PROMPT_PATH="\w"
    if [[ -O ${PWD} ]]; then
        # user owns the cwd
        PROMPT_PATH="$GREEN\w$NORM"
    elif [[ -w ${PWD} ]]; then
        # user can write to the cwd
        PROMPT_PATH="$YELLOW\w$NORM"
    else
        # user can only read the cwd
        PROMPT_PATH="$RED\w$NORM"
    fi

    # default values for git status info
    GIT_PROMPT_PREFIX="("
    GIT_PROMPT_SUFFIX=")"
    GIT_PROMPT_SEPARATOR="|"
    GIT_PROMPT_BRANCH="${MAGENTA}"
    GIT_PROMPT_STAGED="$RED● "
    GIT_PROMPT_CONFLICTS="$RED✖ "
    GIT_PROMPT_CHANGED="$BLUE✚ "
    GIT_PROMPT_REMOTE=" "
    GIT_PROMPT_UNTRACKED="…"
    GIT_PROMPT_CLEAN="${BGREEN}✔"

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
