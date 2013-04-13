
# awk column print shorthand, e.g. print 2nd column: "df -h | fawk 2"
function fawk {
    first="awk '{print "
    last="}' $2"
    cmd="${first}\$${1}${last}"
    echo $cmd
    eval $cmd
}

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

# extract a few known archive files via a common command
function extract-archive()
{
    if [ $# -ne 1 ]
    then
        echo "Error: No archive file specified."
        return 1
    fi
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2) tar xvjf $1;;
            *.tar.gz)  tar xvzf $1;;
            *.bz2)     bunzip2 $1;;
            *.rar)     unrar x $1;;
            *.gz)      gunzip $1;;
            *.tar)     tar xvf $1;;
            *.tbz2)    tar xvjf $1;;
            *.tgz)     tar xvzf $1;;
            *.zip)     unzip $1;;
            *.Z)       uncompress $1;;
            *.7z)      7z x $1;;
            *)         echo "'$1' cannot be extracted via extract-archive command.";;
        esac
    else
        echo "'$1' is not a valid file."
    fi
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

# extract manifest from the given jar file and print it to stdout
function jar-print-manifest()
{
  example 'jar_manifest lib/foo.jar'

    if [ $# -ne 1 ]
    then
        echo "Usage: jar-manifest foo/bar.jar"
        return 1
    fi
    if [ -f $1 ]; then
        unzip -c $1 META-INF/MANIFEST.MF
    else
        echo "'$1' is not a valid file."
    fi
}

# checks whether the given URL is down for everyone or just you ;-)
function down4me()
{
    if [ $# -ne 1 ]
    then
        echo "Usage: down4me <website-url>"
        return 1
    fi

    curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

# try to determine the public ip address
function my-public-ip()
{
    _response=$(curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+')
    echo -e "Your public IP address is: \033[1;32m${_response}\033[0m"
}

# backup given file with the current timestamp
function backup-with-timestamp()
{
    if [ $# -ne 1 ]
    then
        echo "Usage: backup-with-timestamp <path>"
        return 1
    fi
    local filename=$1
    local filetime=$(date +%Y%m%d_%H%M%S)
    cp ${filename} ${filename}_${filetime}
}

# vim: set ts=4 sw=4 tw=0 et :
