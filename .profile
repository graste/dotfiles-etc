printf 'Hostname: ' ; hostname
printf 'Kernel: ' ; uname -smr
printf 'Uptime: ' ; uptime
printf 'Server time: ' ; date

printf '\nDisk usage (w/o tmpfs): \n'
df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs

printf '\nMemory usage (w/o buffers): \n'
free -mot

# lastlog | grep "root" | awk {'print "Last login from : "$3 print "Last Login Date & Time: ",$4,$5,$6,$7,$8,$9;'}
printf '\nLast logins: \n'
lastlog | grep -v 'Never'

printf '\nCurrent users: \n'
w

printf '\nYour are: \n'
who -u am i

printf '\n\n'
