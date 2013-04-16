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

    git clone git://github.com/graste/dotfiles-etc.git
    cd dotfiles-etc && ./copy-files.sh

## Screenshot

Screenshot with a glimpse of vim status line, screen status line and the bash
prompt with exit code coloring and git status information:

![Screenshot of screen/vim/bash/gitprompt](https://raw.github.com/graste/dotfiles-etc/master/screen-vim-bash-gitprompt.png)

## Bash prompt

- `# <time> <history-id> <exit-code> (<git-branch> <git-branch-tracking>|<git-local-status>) <path> $ `
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

### tl;dr

- `~/.profile` for whole session settings like programs to run on log in and the start of the display manager. May be used for environment variable definitions.
- `~/.bashrc` for bash specific settings like alias and function definitions, shell options and prompt settings.
- `~/.inputrc` for key bindings and other input related settings.
- `~/.bash_profile` can be used instead of `~/.profile`, but you also need to include `~/.bashrc` if the shell is interactive.

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

`pathogen` is used to handle plugins, syntax highlighting etc. For details see `.vim/bundles`.

For syntax checking with `syntastic` the following (ubuntu) packages may be useful:

- `sudo apt-get install pylint tidy libxml2-utils make puppet-lint`
- for `jshint`, `jslint` and `csslint`, `less`, `sass`and `js-yaml`:
    - `sudo apt-get install software-properties-common python-software-properties python g++ make`
    - `sudo add-apt-repository ppa:chris-lea/node.js`
    - `sudo apt-get update`
    - `sudo apt-get install nodejs`
    - install globally `sudo npm install -g less sass jshint jslint js-yaml csslint` (or locally: `npm install less sass jshint jslint js-yaml csslint` and add it to `$PATH` or as an alias)
    - things like `coffeelint` if you use those...
- for `twig-lint`:
    - download `http://asm89.github.com/d/twig-lint.phar` and put it into your `$PATH` (e.g. `~/bin`)
    - `cd ~/bin && chmod u+x twig-lint.phar && mv twig-lint.phar twig-lint`

## Sources of inspiration

- The customized git status information prompt was adapted from there: https://github.com/magicmonty/bash-git-prompt
- various dotfiles of other people
