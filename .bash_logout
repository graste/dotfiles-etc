
# if current shell is the topmost shell do some cleanup on exit
if [ "$SHLVL" = 1 ]; then
    # clear console output
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
    # delete mysql history
    #[ -f $HOME/.mysql_history ] && /bin/rm $HOME/.mysql_history
fi

