
# name and email of author
export GIT_AUTHOR_NAME="Steffen Gransow"
export GIT_AUTHOR_EMAIL="graste@mivesto.de"

# name and email of committer
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

# controls amount of output shown by the recursive merge strategy
# level 0-5; default is 2; 5 and above displays debugging information; 0 is nothing except fatal errors
export GIT_MERGE_VERBOSITY=3

# show statistics about current repository (authers, number of commits etc.)
function git_stats {
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        echo "Number of commits per author:"
        git --no-pager shortlog -sn --all
        AUTHORS=$( git shortlog -sn --all | cut -f2 | cut -f1 -d' ')
        LOGOPTS=""
        if [ "$1" == '-w' ]; then
            LOGOPTS="$LOGOPTS -w"
            shift
        fi
        if [ "$1" == '-M' ]; then
            LOGOPTS="$LOGOPTS -M"
            shift
        fi
        if [ "$1" == '-C' ]; then
            LOGOPTS="$LOGOPTS -C --find-copies-harder"
            shift
        fi
        for a in $AUTHORS
        do
            echo '-------------------'
            echo "Statistics for: $a"
            echo -n "Number of files changed: "
            git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f3 | sort -iu | wc -l
            echo -n "Number of lines added: "
            git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f1 | awk '{s+=$1} END {print s}'
            echo -n "Number of lines deleted: "
            git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f2 | awk '{s+=$1} END {print s}'
            echo -n "Number of merges: "
            git log $LOGOPTS --all --merges --author=$a | grep -c '^commit'
        done
    else
        echo "you're currently not in a git repository"
    fi
}

# ignore given pattern only locally (instead of using .gitignore)
function git_local_ignore() {
    echo "$1" >> .git/info/exclude
}

function git_remove_missing_files() {
    git ls-files -d -z | xargs -0 git update-index --remove
}

# show info about current working copy (e.g. if branches are up-to-date with remotes etc.)
function git_info() {

    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        # print informations
        echo "git repo overview"
        echo "-----------------"
        echo

        # print all remotes and thier details
        for remote in $(git remote show); do
            echo $remote:
            git remote show $remote
            echo
        done

        # print status of working repo
        echo "status:"
        if [ -n "$(git status -s 2> /dev/null)" ]; then
            git status -s
        else
            echo "working directory is clean"
        fi

        # print at least 5 last log entries
        echo 
        echo "log:"
        git log -5 --oneline
        echo 
    else
        echo "you're currently not in a git repository"
    fi
}

