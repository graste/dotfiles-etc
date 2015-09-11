# create ctags files in current folder - plus one for the VENDOR directory
function create-ctags()
{
    #ctags -nR --PHP-kinds=+cf --exclude='.git' --exclude=".svn" --exclude="cache" --exclude="*.phar" --exclude="log" --exclude="node_modules" --exclude="bower_components" --exclude="*.min.js" --regex-php='/^[ \t]*trait[ \t]+([a-z0_9_]+)/\1/t,traits/i' -f tags.vendor vendor
    #ctags -nR --PHP-kinds=+cf --exclude='.git' --exclude=".svn" --exclude="cache" --exclude="*.phar" --exclude="log" --exclude="node_modules" --exclude="bower_components" --exclude="*.min.js" --exclude="vendor" --regex-php='/^[ \t]*trait[ \t]+([a-z0_9_]+)/\1/t,traits/i' -f tags .
    ctags -nR --PHP-kinds=+cf --exclude='.git' --exclude=".svn" --exclude="cache" --exclude="codecache" --exclude="*.phar" --exclude="log" --exclude="node_modules" --exclude="bower_components" --exclude="*.min.js" --regex-php='/^[ \t]*trait[ \t]+([a-z0_9_]+)/\1/t,traits/i' -f tags .
}

function getcomposer()
{
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
}

# awk column print shorthand, e.g. print 2nd column: "df -h | fawk 2"
function fawk
{
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
    response=$(curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+')
    echo -e "Your public IP address is: \033[1;32m$response\033[0m"
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

function matrix-effect()
{
    echo -e "\e[1;40m";
    clear;
    while :
    do
        echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 ));
        sleep 0.05;
    done | gawk '{
    letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()";
    c=$4;
    letter=substr(letters,c,1);
    a[$3]=0;
    for (x in a) {
        o=a[x];
        a[x]=a[x]+1;
        printf "\033[%s;%sH\033[2;32m%s",o,x,letter;
        printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;
        if (a[x] >= $1) {
            a[x]=0;
        }
    }
}'
}

# serve <port> (defaults to 9999)
function serve() {
    local usage_text="Usage: serve [port]
Serves the current directory via HTTP on the specified port (defaults to 9999)"

    local help_pattern="-h|--help"
    if [[ $1 =~ $help_pattern ]]; then
        echo "$usage_text"
        return 0
    fi

    local port="${1:-9999}"

    local port_pattern="^[0-9]+$"
    if ! [[ $port =~ $port_pattern ]]; then
        echo "Invalid port argument: \"$1\""
        return 1
    fi

    sleep 1 && open "http://localhost:${port}/" &
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# start php server from current directory with port (defaults to 4000; requires PHP v5.4+)
function phpserver() {
    local port="${1:-4000}"
    local ip=$(ifconfig | grep -i inet[^6] | cut -d: -f2 | cut -d' ' -f1 | tail -n 1)
    sleep 1 && open "http://${ip}:${port}/" &
    php -S "${ip}:${port}"
}

# calculate
function calc() {
    local result=""
    result="$(printf "scale=5;$*\n" | bc -l | tr -d '\\\n')"
    if [[ "$result" == *.* ]]; then
        echo $result | sed -e 's/^\./0./' -e 's/^-\./-0./' -e 's/0*$//;s/\.$//'
    else
        echo $result
    fi
}

# create a data uri from a file
function dataurl() {
    local mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]; then
            mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# compare original and gzipped file sizes
function gz() {
    local orig_size=$(wc -c < "$1")
    local gzip_size=$(gzip -c "$1" | wc -c)
    local size_ratio=$(echo "scale=3; $gzip_size * 100 / $orig_size" | bc -l)
    printf "orig: %d bytes\n" "$orig_size"
    printf "gzip: %d bytes (%s%%)\n" "$gzip_size" "$size_ratio"
}

# escape UTF-8 characters into their 3-byte format
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    if [ -t 1 ]; then
        echo
    fi
}

# decode \x{ABCD} unicode escape sequences
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    if [ -t 1 ]; then
        echo
    fi
}

# get a character's unicode code point
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
    if [ -t 1 ]; then
        echo
    fi
}

# find 10 most frequently used words in a given text file
function words-most-freq() {
    if [ $# -ne 1 ]
    then
        echo "Usage: words-most-freq <path-to-text-file>"
        return 1
    fi

    cat $1 | tr -s '[:space:]' '\n' | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -nr | head -10
}

# pretty print JSON strings or files
function json() {
    if [ -t 0 ]; then
        python -mjson.tool <<< "$*" | pygmentize -l javascript
    else
        python -mjson.tool | pygmentize -l javascript
    fi
}

# vim: set ts=4 sw=4 tw=0 et :
