
# remind with desktop notification (ubuntu only atm)
function remind()
{
    if [ -n "$2" ]; then
        sleep $1 && notify-send "$2" &
    else
        echo "Usage: remind 15m 'you gotta leave!'"
    fi;
}

# list configured hosts from .ssh/config file
function ssh-list()
{
    awk '$1 ~ /Host$/ { print $2 }' ~/.ssh/config
}

# quick info about data files
function i()
{
    (head -n 5;tail -n 5) < "$1" | column -t
}

# resize remote image to local file with given width via curl/webservice
function resize-web-image()
{
    if [ "" = "$3" ]; then
        echo "Usage: resize-web-image '<image-url>' <width> <outputfile>";
    else
        local imageUrl=$1;
        local width=$2;
        local outputfile=$3;
        curl -o $outputfile http://src.sencha.io/$width/$imageUrl;
    fi
}

# vim: set ts=4 sw=4 tw=0 et :
