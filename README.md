# Configuration files

Various dotfiles I use and want to have available elsewhere. Probably a lot of this is Ubuntu-only so handle with care if you re-use aliases etc. :-)

- `.bash*` settings for bash (prompt, aliases, functions)
- `.inputrc` settings for keyboard input (like case insensitive completion)
- `.vimrc` settings for vim (not vi; mappings, functions etc.)
- `.screenrc` settings for screen (not tmux yet)
- `.ackrc` settings for ack (or ack-grep how it's called in Debian repositories)
- `.git*` default settings and ignores for git
- `.profile` commands to execute after login (basic system information)
- `.pam_environment` user environment locale settings with one assignment expression per line (I prefer english/utf-8 messages with german numbers and dates etc.)

## Usage

Clone the repository to a folder of your choice and copy wanted or all files:

    git clone --depth=1 git://github.com/graste/dotfiles-etc.git
    cd dotfiles-etc && ./copy-files.sh [all]

Without installed `git` you can try to use `curl` or `wget`:

    curl -#L https://github.com/graste/dotfiles-etc/tarball/master | tar -xzv --strip-components 1

## Screenshot

Screenshot with a glimpse of vim status line, screen status line and the bash
prompt with exit code coloring and git status information:

![Screenshot of screen/vim/bash/gitprompt](https://raw.github.com/graste/dotfiles-etc/master/screen-vim-bash-gitprompt.png)

## Bash prompt

    # <time> <history-id> <exit-code> (<git-branch> <git-branch-tracking>|<git-local-status>) <path> $

- `#` mitigates execution of accidental pastes in the command line
- `<time>` as often long running commands are not called with the `time` bash builtin
- `<history-id>` to execute earlier commands via `!<history-id>` when seeing one in the scrollback buffer
- `<exit-code>` shell exit code of last command (color in bold red if it's not zero)
- `(<git-branch> <git-branch-tracking>|<git-local-status>)` displays detailed useful information about the git repository in the current working directory (not displayed if not in a git directory)
    - `<git-branch>` name of the currently checked out branch
    - `<git-branch-tracking>` number of commits ahead/behind of remote
    - `<git-local-status>` number of staged/modified/conflicted/untracked files
- `<path>` current working directory shortened via `PROMPT_DIRTRIM=3` environment variable and colored according to user permissions
    - in green: user owns directory
    - in yellow: user is allowed to write in directory
    - in red: user is not allowed to write in directory

You can disable the `git` part of the prompt by exporting `USE_GIT_IN_PROMPT=no`:

    # 18:11:01 0 (master|✚ 1) ~/projects/graste/dotfiles-etc $ export USE_GIT_IN_PROMPT=no
    # 18:11:03 0 ~/projects/graste/dotfiles-etc $ 

## Bash

- RTFM: [Bash Reference Manual](http://www.gnu.org/software/bash/manual/bashref.html)
- `echo $-`: list shell options - if it contains an `i` the shell is interactive (that is: no script but user input)
- normal bash startup order is (first wins): `/etc/profile`, `~/.bash_profile`, `~/.bash_login` and `~/.profile`
- typically `~/.bash_profile` executes `~/.bashrc` (not vice versa)
- `~/.bash_profile` is executed for login shells while `~/.bashrc` is executed for interactive non-login shells
- to really execute `~/.bash_profile` start bash with a `-l` or `--login` option
- put bash unspecific things in `~/.profile` as switching shells becomes easier
- bash specific settings should be set in `~/.bashrc` (as it may not be your login shell)

### word modifiers

- `p` print
- `h` head - remove a trailing file name component, leaving only the head
- `t` tail - remove all leading file name components, leaving the tail
- `r` remove a trailing suffix of the form .xxx, leaving the basename
- `e` remove all but the trailing suffix
- `s` substitue strings (replace first match)
- `gs` global substitute (replace all matches)
- `&` repeat the previous substitution
- word modifiers are stackable
- words are whitespace delimited

### history handling

- `!!` repeat last command from history
- `!foo` repeat last command beginning with `foo`
- `!foo:p` print last command beginning with `foo` - it adds to the history as well, thus you cann use `!!` directly if the command looks good
- `!N` execute the command with number `N`
- `!-N` execute the command `N` commands ago
- `!$` reuse the 'end' of the last command (reuse the last word)
- `!$:p` print last argument from previous command (`:p` is a `word modifier`)
- `!*` reuse all arguments from previous command
- `!#:1` reuse second argument from current command (```ls foo !#:1``` => ```ls foo foo```)
- `^error^correction` correct and execute previous command (replace and execute)
- given the command `cat /usr/local/share/doc/foo/bar.baz`:
    - `cd !$:h` change to directory (`:h` removes `bar.baz`)
    - `cat !-2$:t` open `bar.baz` as that is the tail of the 2nd last command
    - `mkdir !-3$:t:r` create directory `bar` (`:t` removes tailing path and `:r` removes the `.baz` extension)
- `!!:s/foo/bar/` execute last command with the first `foo` occurrence replaced by `bar`
- `!!:gs/foo/bar/` execute last command with all occurrences of `foo` replaced by `bar`
- `!!:s/foo/&.bar/` - execute the last command with the first `foo` replaced by `.bar`

### shortcuts

- `<alt+.>` to insert last argument on current cursor position (repeatable)
- `<ctrl+w>` erase word
- `<ctrl+u>` erase from cursor to beginning of the line
- `<ctrl+a>` move the cursor to the beginning of the line
- `<ctrl+e>` move the curor to the end of the line

### brace expansion

- `cp filename{,-old}` copy `filename` to `filename-old`
- `cp filename{-v1,-v2}` copy `filename-v1` to `filename-v2`
- `touch foo{1,2,3}bar` create files `foo1bar`, `foo2bar` and `foo3bar`
- multiple brace expansions can be used together and nested (not that that would be readable)

### various stuff

- `|&` === `2>&1 |`: standard error of command1 is connected to command2's standard input through the pipe
- `set` command
    - `set -o`: list currently configured shell options
    - `set -o variable_name`: set option
    - `set +o variable_name`: unset option
    - `set +e ; command_that_might_fail_but_we_want_to_ignore_it ; set -e` === `command_that_might_fail_but_we_want_to_ignore_it || true`
- `shopt` command
    - `shopt -p`: list of some of the currently configured variables that control optional behaviour
    - `shopt -s option_name`: enable/set option
    - `shopt -u option_name`: disable/unset option
- `echo $SHLVL`:  get subshell level (toplevel is 1)
- default time format: ``TIMEFORMAT=$'\nreal\t%3lR\nuser\t%3lU\nsys\t%3lS'``
- diff two file listings via [process substitution](http://tldp.org/LDP/abs/html/process-sub.html): ```diff <(ls -1a ./dir1) <(ls -1a ./dir2)``` or use ```diff -bur dir1 dir2```

### tl;dr

- `~/.profile` for whole session settings like programs to run on log in and the start of the display manager. May be used for environment variable definitions.
- `~/.bashrc` for bash specific settings like alias and function definitions, shell options and prompt settings.
- `~/.inputrc` for key bindings and other input related settings.
- `~/.bash_profile` can be used instead of `~/.profile`, but you also need to include `~/.bashrc` if the shell is interactive.

See e.g. [Unix shell initialization](https://github.com/sstephenson/rbenv/wiki/Unix-shell-initialization) for a short introduction on different shells and their startup files.

## Locale settings

The `~/.pam_environment` file contains session-wide user-environment locale settings with one assignment expression per line. To activate changes to this file one has to _re-login_.

- `LANG` basic language setting used by applications on the system (may be overridden by more specific locale environment variables)
- `LC_CTYPE` character set used to display and input text
- `LC_NUMERIC` how non-monetary numeric values are formatted on screen
- `LC_TIME` how date and time values are formatted
- `LC_COLLATE` how to sort various information items (e.g. sort command behaviour)
- `LC_MONETARY` how monetary numeric values are formatted
- `LC_MESSAGES` language to display messages to the end user
- `LC_PAPER` definitions of paper formats and standards
- `LC_NAME` how names are formatted
- `LC_ADDRESS` how to display address information
- `LC_TELEPHONE` how telephone numbers are structured
- `LC_MEASUREMENT` what units of measurement are used
- `LC_IDENTIFICATION` metadata about the locale information
- `LC_ALL` override over all the other locale environment variables (applications use this variable if it's set, regardless of other variables' values)

## Vim bundles

`pathogen` is used to handle plugins, syntax highlighting etc. For details see [`.vim/bundle`](.vim/bundle).

For syntax checking with `syntastic` the following (ubuntu) packages may be useful:

- `sudo apt-get install pylint tidy libxml2-utils make puppet-lint`
- for other (nodejs based) linters (see [here for nodejs install](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions) or use [chris lea PPA on older Ubuntu](https://launchpad.net/~chris-lea/+archive/ubuntu/node.js/):
    - `curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -`
    - `sudo apt-get install -y nodejs`
    - `npm install -g less sass sass-lint jshint js-yaml csslint jsonlint dockerfile_lint markdownlint-cli` (`.bashrc` exports `NPM_CONFIG_PREFIX=~/.npm-global`)
- for `vim-php-namespace` to work, [exuberant-ctags](http://ctags.sourceforge.net/) is necessary.
    - `sudo apt-get install exuberant-ctags`
- `sudo apt-get install software-properties-common python-software-properties python g++ make python-pygments`
- `gem install ruby-lint puppet-lint flog scss_lint haml_lint`

## Ctags

Generate ctags completion files in your project's root folder like this:

```bash
ctags -nR --PHP-kinds=+cf --exclude='.git' --exclude='*.phar' --exclude="*.min.js" --regex-php='/^[ \t]*trait[ \t]+([a-z0_9_]+)/\1/t,traits/i' -f tags .
```

There's a bash function called `create-ctags` that may be called in project directories to create a `tags` file (see [`.bash/functions.sh`](.bash/functions.sh)).

## Sources/inspiration

- The customized git status information prompt was adapted from: <https://github.com/magicmonty/bash-git-prompt>
- various dotfiles of other people (e.g. bash functions `calc`, `json`, `gz`, `unidecode`, `escape` from @mathiasbynens)
- [`bin/git-open`](https://github.com/paulirish/git-open)
- [`bin/twig-lint`](https://github.com/asm89/twig-lint)
- [`bin/phpcs`](https://github.com/squizlabs/PHP_CodeSniffer)
