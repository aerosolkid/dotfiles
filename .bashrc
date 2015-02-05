id=`id -u`
hnam=`hostname -s | tr '[:upper:]' '[:lower:]'`

shopt -s histappend
shopt -s cdspell
shopt -s cmdhist
export HISTIGNORE="&:ls:[bf]g:exit"

export PATH=/usr/local/mysql/bin:$PATH
export PATH=/usr/local/bin:$PATH
#export PATH=/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:$PATH
export PATH=~/Dropbox/bin:$PATH
export PATH=$HOME/bin:/usr/X11R6/bin:$PATH

export LD_LIBRARY_PATH=/opt/local/lib

export MANPATH=/opt/local/man:$MANPATH

export DISPLAY=:0.0

if [ -f ~/.git-prompt.sh ]
then
    source ~/.git-prompt.sh
fi

## Yoinked from: http://blog.grahampoulter.com/2011/09/show-current-git-bazaar-or-mercurial.html
## Print nickname for git/hg/bzr/svn version control in CWD
## Optional $1 of format string for printf, default "(%s) "
function be_get_branch {
  local dir="$PWD"
  local vcs
  local nick
  while [[ "$dir" != "/" ]]; do
    for vcs in git hg svn bzr; do
      if [[ -d "$dir/.$vcs" ]] && hash "$vcs" &>/dev/null; then
        case "$vcs" in
          git) __git_ps1 "${1:-(git:%s)}"; return;;
          hg) nick=$(hg branch 2>/dev/null);;
          svn) nick=$(svn info 2>/dev/null\
                | grep -e '^Repository Root:'\
                | sed -e 's#.*/##');;
          bzr)
            local conf="${dir}/.bzr/branch/branch.conf" # normal branch
            [[ -f "$conf" ]] && nick=$(grep -E '^nickname =' "$conf" | cut -d' ' -f 3)
            conf="${dir}/.bzr/branch/location" # colo/lightweight branch
            [[ -z "$nick" ]] && [[ -f "$conf" ]] && nick="$(basename "$(< $conf)")"
            [[ -z "$nick" ]] && nick="$(basename "$(readlink -f "$dir")")";;
        esac
        [[ -n "$nick" ]] && printf "${1:-(%s:%s)}" "$vcs" "$nick"
        return 0
      fi
    done
    dir="$(dirname "$dir")"
  done
}

## Add branch to PS1 (based on $PS1 or $1), formatted as $2
export GIT_PS1_SHOWDIRTYSTATE=yes
#export PS1="\$(be_get_branch "$2")${PS1}";

#http://bashrcgenerator.com
export PS1="\[\e[00;33m\]\u\[\e[0m\]\[\e[00;37m\]@\h:\[\e[0m\]\[\e[00;36m\][\W\[\e[0m\]\[\e[00;35m\]\$(be_get_branch "$2")\[\e[0m\]\[\e[00;36m\]]\[\e[0m\]\[\e[00;37m\]\\$ \[\e[0m\]"

if [ "${hnam}" != "omaedcwww044" ]
then
    export TNS_ADMIN="/Usrs/mpc/instantclient_10_2"
else
    export LPDEST=HP_Laserjet_8150
    export LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.4/client/lib
    alias hux='cd ~/www/huxley'
    alias nagchk='/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg'
fi

export PATH=$PATH:$TNS_ADMIN/bin

alias ls='ls -h --color=auto'
alias l='ls -ltr --color=auto | tail'

alias who='who -uH'
alias h='history'
alias cls='clear'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias showmethepackets="sudo tcpdump -A -p -q -s0 src port 80 or dst port 80"

alias top='/usr/bin/top -o cpu -O vsize -S'

# Show lines that are not blank or commented out
alias active='grep -v -e "^$" -e"^ *#"'

# Show which commands you use the most
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

# Make a directory and CD into it
function mcd() {
  mkdir -p "$1" && cd "$1";
}

# What's eating up all the memory?
alias wotgobblemem='ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15'

# Tail with search highlight
t() { 
tail -f $1 | perl -pe "s/$2/\e[1;31;43m$&\e[0m/g"
}

# copy public key to remote machine 
function authme() {
  ssh "$1" 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys' \
    < ~/.ssh/id_dsa.pub
}

# Yoinked from http://brettterpstra.com/2009/11/14/fk-a-useful-bash-function/
# FK: ‘fk’ is short for Find and Kill, and it does a quick search of your
# running processes for a case-insensitive partial match of the first parameter
# passed to it
#
# run fk process, where process is a partial name of a running application or
# UNIX process. You’ll get a menu with the matches, and you can kill a
# specific process by typing its number at the prompt.
# "Cancel" is the first option.

fp () { #find and list processes matching a case-insensitive partial-match string
                ps Ao pid,comm|awk '{match($0,/[^\/]+$/); print substr($0,RSTART,RLENGTH)": "$1}'|grep -i $1|grep -v grep
}

fk () { 
        IFS=$'\n'
        PS3='Kill which process? (1 to cancel): '
        select OPT in "Cancel" $(fp $1); do
                if [ $OPT != "Cancel" ]; then
                        kill $(echo $OPT|awk '{print $NF}')
                fi
                break
        done
        unset IFS
}

# Start an HTTP server from a directory, optionally specifying the port

function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -m SimpleHTTPServer "$port"
}

umask 002
