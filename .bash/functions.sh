
# remind with desktop notification (ubuntu only atm)
function remind()
{
    if [ -n "$2" ]; then
        sleep $1 && notify-send "$2" &
    else
        echo "Usage: remind 15m 'you gotta leave!'"
    fi;
}

# quick info about data files
i(){
    (head -n 5;tail -n 5) < "$1" | column -t
}

