echo "Welcome to the dark side of the moon, $USER!"
echo -e "Today is $(date)\nUptime: $(uptime)"
echo "Your personal settings have been loaded successfully."

#-----------
# Searching:
#-----------
# ff:  to find a file under the current directory
ff () { /usr/bin/find . -name "$@" ; }
# ffs: to find a file whose name starts with a given string
ffs () { /usr/bin/find . -name "$@"'*' ; }
# ffe: to find a file whose name ends with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }

# grepfind: to grep through files found by find, e.g. grepf pattern '*.c'
# note that 'grep -r pattern dir_name' is an alternative if want all files 
grepfind () { find . -type f -name "$2" -print0 | xargs -0 grep "$1" ; }
# I often can't recall what I named this alias, so make it work either way: 
alias findgrep='grepfind'

# locaterecent: to search for files created since yesterday using Spotlight
# This is an illustration of using $time in a query
# See: http://developer.apple.com/documentation/Carbon/Conceptual/SpotlightQuery/index.html
function locaterecent { mdfind 'kMDItemFSCreationDate >= $time.yesterday'; }

# find_larger: find files larger than a certain size (in bytes)
find_larger() { find . -type f -size +${1}c ; }

# numberLines: echo the lines of a file preceded by line number
numberLines () { perl -pe 's/^/$. /' "$@" ; }

# findPid: find out the pid of a specified process
#    Note that the command name can be specified via a regex
#    E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#    Without the 'sudo' it will only find processes of the current user
findPid () { sudo /usr/sbin/lsof -t -c "$@" ; }

# to find memory hogs:
alias mem_hogs_top='top -l 1 -o rsize -n 10'
alias mem_hogs_ps='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

# to find CPU hogs
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

# ql: show a "Quick Look" view of files
ql () { /usr/bin/qlmanage -p "$@" >& /dev/null & }




# top
alias cpu='top -o cpu'
alias mem='top -o rsize' # memory

#copy output of last command to clipboard
alias cl="fc -e -|pbcopy"

# list TODO/FIX lines from the current project
alias todos="ack -n --nogroup '(TODO|FIX(ME)?):'"

#killing process
kp () {
  ps aux | grep $1 > /dev/null
  mypid=$(pidof $1)
  if [ "$mypid" != "" ]; then
    kill -9 $(pidof $1)
    if [[ "$?" == "0" ]]; then
      echo "PID $mypid ($1) killed."
    fi
  else
    echo "None killed."
  fi
  return;
}

# process info
psa () {
  ps aux | grep $1
}

# disk usage
ssd () {
  echo "Device         Total  Used  Free  Pct MntPoint"
  df -h | grep "/dev/sd"
  df -h | grep "/mnt/"
}

# colorful manpages
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode – red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode – bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode – yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode – cyan



