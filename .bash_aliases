#
# basic shell usage
#

# navigation to parent directories should be easy
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'

# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# most recently modified files at bottom with human readable size
alias lt='ls -lhart'

# don't open less if output fits screen etc. - unnecessary if LESS variable is exported
#alias less='less -FirSwX'

# create non-existing parent directories automatically
alias mkdir='mkdir -pv'

# type is more reliable than which
alias which='type -a'

# time and date commands
alias now='date +"%d-%m-%Y %T"'
alias nowtime='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

# we want vim
alias vi=vim
alias svi='sudo vim'

# continue wget downloads by default
alias wget='wget -c'

# "rsync" instead of "cp" - progress bar on file copy.
alias cp-with-progress="rsync --progress -ravz"

# you should use more "ack-grep" instead of "grep" :-)
alias ack='ack-grep'



#
# safety features
#

# do not delete / or prompt if deleting more than 3 files at a time
alias del='rm -I --preserve-root'

# confirm copy/move/link
alias mv_='mv -i'
alias cp_='cp -i'
alias ln_='ln -i'

# do not change permissions on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'



#
# various system, services and directory information
#

# show status of all services
alias services='service --status-all'
alias services-all="services 2>&1 | grep '\[ . \]' | awk '{print \$4}' ; initctl list"
alias services-started="services 2>/dev/null | grep '\[ + \]' | awk '{print \$4}' ; initctl list | grep running"
alias services-stopped="services 2>/dev/null | grep '\[ - \]' | awk '{print \$4}' ; initctl list | grep waiting"

# show current connections
alias connections='sudo lsof -n -P -i +c 15'

# show open udp/tcp ports
alias ports='netstat -tulanp'

# show sockets
alias sockets='ss ; ss -s'

# list IPs
alias ips="ifconfig | grep -i inet[^6] | cut -d: -f2 | cut -d' ' -f1"

# list MAC addresses
alias macs="ifconfig | grep -i hwad | awk '{print \$5}'"

# human readable mounts list
alias mounts='mount | column -t'

# tail all logs
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# list folders by size in current directory
alias usage="du -h --max-depth=1 | sort -rh"

# disk usage in current directory
alias diskusage='du -ch 2> /dev/null |tail -1'

# show total and human readable output of first level by default
alias diskusage1='du -chd 1'

# find biggest directories
alias ducks='du -ck | sort -nr | head'

# human readable with filesystem type by default
alias diskfree='df -hT'

# shows the individual partition usages without the temporary memory values
alias diskfree1='df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs'

# size of folder in current directory
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"

# poor man's tree version
alias findtree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias filetree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# colors of current bash
alias showcolors='printf "\e[%dm%d dark\e[0m  \e[%d;1m%d bold\e[0m\n" {30..37}{,,,}'

# show directories in $PATH
alias path="echo -e ${PATH//:/\\n}"

# list all iptables rules
alias firewall='sudo /sbin/iptables -L -n -v --line-numbers'

# show current subnet
alias subnet="netstat -nr | grep -m 1 -iE 'default|0.0.0.0' | awk '{print \$2}' | sed 's/\.[0-9]*$//'"

# find webservers in current subnet
alias findhttpd='nmap -p 80 $(subnet).*'

# stop after sending N ECHO_REQUEST packets
alias shortping='ping -c 3'

# do not wait interval 1 second
alias fastping='ping -c 100 -i.2'

# find all symlinks pointing to their parent directories or above
alias symlinks-to-parent-directories="find . -type l -printf \"'%p' -> '%l'\n\" | grep '\.\./'"



#
# cool stuff
#

# only show active lines (not commented or blank), e.g. httpd.conf
alias nocomment='grep -v -e "^$" -e"^\s*#"'
alias nocomment-semicolon='grep -v -e "^$" -e"^\s*;"'
alias lines='grep -v -e "^$" -e"^\s*#"'
alias lines2='egrep -v "^\s*(#|$)"'

# awk column print shorthand, e.g. print 2nd column: "df -h | fawk 2"
function fawk {
    first="awk '{print "
    last="}' $2"
    cmd="${first}\$${1}${last}"
    echo $cmd
    eval $cmd
}

# stream desktop to other ip
alias streamlaptop="vlc screen:// :screen-fps=30 :screen-caching=100 --sout '#transcode{vcodec=mp4v,vb=4096,acodec=mpga,ab=256,scale=1,width=1280,height=800}:rtp{dst=192.168.1.101,port=1234,access=udp,mux=ts}'"

# alert alias for long running commands - usage: "sleep 10; alert"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# creates a simple http server within the current working directory on port 8080
alias pyhttp='python -m SimpleHTTPServer 8080'
alias serve='python -m SimpleHTTPServer 8080'

#echo "some text" | enscript -B -f Courier-Bold16 -o- | ps2pdf - | pdftk input.pdf stamp - output output.pdf

# wake up remote device over lan
#alias wakeup-nas01='/usr/bin/wakeonlan 00:11:22:33:44:FC'

# return random 7-char english names if needed
alias random-name="cat /usr/share/dict/words | rl | grep -vP \"^\w{8,}\" | grep -vP \"'s$\" | head -1"



#
# convenience stuff
#

# try "sudo chmod u+s /sbin/shutdown" if password prompt sucks too much
if [ $EUID -ne 0 ]; then
    alias shutdown='sudo shutdown –h now'
    alias poweroff='sudo poweroff'
    alias restart='sudo shutdown –r now'
    alias suspend='sudo pm-suspend'
else
    alias shutdown='shutdown -h now'
    alias restart='shutdown -r now'
    alias suspend='pm-suspend'
fi

# lock gnome session
alias lock='gnome-screensaver-command --lock'

# turn screen off
alias screenoff='xset dpms force off'



#
# personal stuff
#

# git aliases
alias log='git log --pretty=format:"%h %ai | %s%d [%an]" --graph --date=short '

# start temporary secure opera instance with cache on ramdisk
alias banking='TEMPDIR=$(mktemp -d --tmpdir=/dev/shm) && cp ~/secure_operaprefs.ini $TEMPDIR/operaprefs.ini && /usr/bin/opera -pd $TEMPDIR &'

# craur
alias craur=/home/graste/projects/Craur/php/craur

alias troll="echo \"What you've just written is one of the most insanely idiotic things I have ever heard. At no point in your rambling, incoherent response were you even close to anything that could be considered a rational thought. Everyone here is now dumber for having read it. I award you no points and downvote instead."
