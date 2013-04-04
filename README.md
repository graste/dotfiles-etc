# Configuration files

## Usage

    git clone git://github.com/graste/dotfiles-etc.git
    cd dotfiles-etc && ./copy-files.sh

## Bash

- RTFM: [Bash Reference Manual](http://www.gnu.org/software/bash/manual/bashref.html)
- `echo $-`: list shell options - if it contains an `i` the shell is interactive (that is: no script but user input)
- normal bash startup order is (first wins): `/etc/profile`, `~/.bash_profile`, `~/.bash_login` and `~/.profile`
- typically `~/.bash_profile` executes `~/.bashrc` (not vice versa)
- `~/.bash_profile` is executed for login shells while `~/.bashrc` is executed for interactive non-login shells
- to really execute `~/.bash_profile` start bash with a `-l` or `--login` option
- put bash unspecific things in `~/.profile` as switching shells becomes easier
- bash specific settings should be set in `~/.bashrc` (as it may not be your login shell)
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
- ``shopt -s interactive_comments``

## tl;dr

- `~/.profile` for whole session settings like start programs on log in (but not graphical programs, they go into a different file) and environment variable definitions.
- `~/.bashrc` for bash specific settings like alias and function definitions, shell options and prompt settings.
- `~/.inputrc` for key bindings and other input related settings.
- `~/.bash_profile` can be used instead of `~/.profile`, but you also need to include `~/.bashrc` if the shell is interactive.
- `~/.profile` is nowadays not always read when one logs in in a graphical environment (that is, if the program where you type your password is running in graphics mode).

## Changelog

First draft from 2013-04-02 with fixes on 2013-04-04.

