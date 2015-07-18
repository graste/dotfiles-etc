
# name and email of author
export GIT_AUTHOR_NAME="Steffen Gransow"
export GIT_AUTHOR_EMAIL="github@mivesto.de"

# name and email of committer
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

# controls amount of output shown by the recursive merge strategy
# level 0-5; default is 2; 5 and above displays debugging information; 0 is nothing except fatal errors
export GIT_MERGE_VERBOSITY=3

# show statistics about current repository (authers, number of commits etc.)
function git-show-statistics()
{
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        echo "Number of commits per author:"
        git --no-pager shortlog -sn --all
        AUTHORS=$( git shortlog -sn --all | cut -f2- | tr ' ' '#')
        _num_authors=${#AUTHORS[@]}
        if [ ${_num_authors} -ge 1 ]; then
            echo "Modification details per author:"
        fi
        for author in $AUTHORS
        do
            _author=${author//#/ }
            _files_changed=$(git log --all --numstat --format="%n" --author="${_author}" | cut -f3 | sort -iu | wc -l)
            _lines_added=$(git log --all --numstat --format="%n" --author="${_author}" | cut -f1 | awk '{s+=$1} END {print s}')
            _lines_deleted=$(git log --all --numstat --format="%n" --author="${_author}" | cut -f2 | awk '{s+=$1} END {print s}')
            _merges_done=$(git log --all --merges --author="${_author}" | grep -c '^commit')
            echo "${_author}: ${_files_changed} files changed, ${_lines_added} lines added, ${_lines_deleted} lines deleted, ${_merges_done} merges done"
        done
        echo ""
    else
        echo "You are not in a git repository."
    fi
}

# ignore given pattern only locally (instead of using .gitignore)
function git-ignore-local()
{
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        _exclude_file="$(git rev-parse --show-toplevel)/.git/info/exclude"
        if [ "" = "$1" ]; then
            echo "Usage: git-local-ignore <file_or_pattern>"
            echo ""
            echo "Current entries in ${_exclude_file}:"
            echo ""
            cat ${_exclude_file}
            echo ""
        else
            echo "$1" >> ${_exclude_file}
        fi
    else
        echo "You are not in a git repository."
    fi
}

# change into the root directory of the current git working copy
function git-goto-root()
{
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        cd $(git rev-parse --show-toplevel)
    else
        echo "You are not in a git repository."
    fi
}

# show absolute path of current git working copy
function git-root()
{
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        echo $(git rev-parse --show-toplevel)
    else
        echo "You are not in a git repository."
    fi
}

# git rm missing files
function git-remove-missing-files()
{
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        git ls-files -d -z | xargs -0 git update-index --remove
    else
        echo "You are not in a git repository."
    fi
}

# display time since the last commit
function git-show-time-since-last-commit()
{
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        now=`date +%s`
        last_commit=`git log --pretty=format:'%at' -1`
        seconds=$((now-last_commit))
        _days=$(printf "scale=0;$seconds / 86400\n" | bc -l)
        _hours=$(printf "scale=0;($seconds / 3600) - ($_days * 24)\n"  | bc -l)
        _minutes=$(printf "scale=0;($seconds / 60) - ($_days * 1440) - ($_hours * 60)\n" | bc -l)
        _seconds=$(printf "scale=0;$seconds %% 60\n" | bc -l)
        printf "${_days:-0}d ${_hours:-0}h ${_minutes:-0}m ${_seconds:-0}s since last commit.\n"
    else
        printf "You are not in a git repository."
    fi
}

# show info about current working copy (e.g. if branches are up-to-date with remotes etc.)
function git-show-info()
{
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        echo "Git repository overview"
        echo "-----------------------"
        echo ""

        # print some recent log entries
        echo "Log of last week:"
        git log --pretty=format:'%h %ad | %s%d [%an]' --since='7 days ago' --graph --date=relative
        echo ""

        # print details for all remotes
        for remote in $(git remote show); do
            echo "Remote ${remote}:"
            git remote show $remote
            echo ""
        done

        # print status of current working repository
        echo "Short status for current working directory:"
        if [ -n "$(git status -s 2> /dev/null)" ]; then
            git status -s
        else
            echo "Working directory is clean."
        fi
        echo ""
    else
        echo "You are not in a git repository."
    fi
}

