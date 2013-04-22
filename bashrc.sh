# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# message too long fix
if [ ${TERM} != "dumb" ]; then
 test -s ~/.bashrc-local && . ~/.bashrc-local
fi

[ -z '$PS1' ] && return

# Basic options
export HISTCONTROL=ignoredups:ignorespace:ignoreboth
export COLORFGBG='default;default'
# leave some commands out of history log
export HISTIGNORE='&:??:[ ]*:clear:exit:logout'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT='%H:%M > '
export HISTIGNORE='&:bg:fg:h'
# Sets up history length
export HISTSIZE=10000
export HISTFILESIZE=50000
#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

ulimit -S -c 0          # Don't want any coredumps.
set -o notify
set -o noclobber
set -o ignoreeof
set -o nounset

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s mailwarn

# put some colors in ls
export CLICOLOR=1
export LSCOLORS=ExFxCxDxCxegedabagacad

# Aliases
alias ls='ls -h --color=auto'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias h='cd'
alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../..'
alias back='cd $OLDPWD'
alias su='sudo su'
alias grep='grep --color=auto'
alias dfh='df -h'
alias bye='exit'
# Automatically determines filename
alias wget="wget --content-disposition"

# handy file conversion tools
#alias dos2unix="perl -pi -e 's/\r\n/\n/;'"
alias unix2dos="perl -pi -e 's/\n/\r\n/;'"
alias bomstrip="sed -i -s -e '1s/^\xef\xbb\xbf//'"

# Prompt
NORMAL="\[\033[00m\]"
BLACK="\[\033[0;30m\]"
DGRAY="\[033[1;30m\]"
RED="\[\033[0;31m\]"
LRED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
LGREEN="\[\033[1;32m\]"
BROWN="\[\033[0;33m\]"
YELLOW="\[\033[1;33m\]"
BLUE="\[\033[0;34m\]"
LBLUE="\[\033[1;34m\]"
PURPLE="\[\033[0,35m\]"
LPURPLE="\[\033[1;35m\]"
CYAN="\[\033[0;36m\]"
LCYAN="\[\033[1;36m\]"
LGRAY="\[\033[0;37m\]"
WHITE="\[\033[1;37m\]"
PS1="${LGREEN}\u${LPURPLE}@${LRED}\H${CYAN}[${YELLOW}\w${CYAN}]${LGRAY}>${WHITE}"
PS2="${GREEN}->"
PS3="${LPURPLE}*?"
export PS1
export PS2
export PS3

# Paths
if [ -d "$HOME/python27/bin" ]; then
    PATH="$HOME/python27/bin:$PATH"
fi
if [ -d "$HOME/env/bin" ]; then
    PATH="$HOME/env/bin:$PATH"
fi
#-------------------------------------------------------------
# tailoring 'less'
#-------------------------------------------------------------

alias more='less'
export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
   # Use this if lesspipe.sh exists
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'


#-------------------------------------------------------------
# spelling typos - highly personnal and keyboard-dependent :-)
#-------------------------------------------------------------

alias cs='cd'
alias vf='cd'
alias vd='cd'
alias moer='more'
alias moew='more'
alias kk='ll'

#-------------------------------------------------------------
# A few fun ones
#-------------------------------------------------------------


function xtitle()      # Adds some text in the terminal frame.
{
    case '$TERM' in
        *term | rxvt)
            echo -n -e '\033]0;$*\007' ;;
        *)
            ;;
    esac
}
# aliases that use xtitle
alias top='xtitle Processes on ${HOSTNAME} && top'
alias make='xtitle Making $(basename $PWD) ; make'
alias ncftp='xtitle ncFTP ; ncftp'

#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------


function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-'.*'} ; }
function killps()                 # Kill by process name.
{
    local pid pname sig='-TERM'   # Default signal.
    if [ '$#' -lt 1 ] || [ '$#' -gt 2 ]; then
        echo 'Usage: killps [-SIGNAL] pattern'
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask 'Kill process $pid <$pname> with signal $sig?'
            then kill $sig $pid
        fi
    done
}

function my_ip() # Get IP adresses.
{
    MY_IP=$(/sbin/ip addr show venet0 | awk '/inet/ { print $2 } ' | \
sed -e s/addr://)
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-'Not connected'}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-'Not connected'}
    echo -e "\n${RED}Open connections :$NC "; netstat -pan --inet;
    echo
}
#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------

function repeat()       # Repeat n times command.
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval '$@';
    done
}
function ask()          # See 'killps' for example of use.
{
    echo -n '$@' '[y/n] ' ; read ans
    case '$ans' in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}
function corename()   # Get name of app that created a corefile.
{
    for file ; do
        echo -n $file : ; gdb --core=$file --batch | head -1
    done
}

function get() { printf "\033]0;__pw:"`pwd`"\007" ;
for file in $* ; do printf "\033]0;__rv:"${file}"\007" ; done ;
printf "\033]0;__ti\007" ; }

function winscp() { echo -ne \"\\033];__ws:${PWD}\\007\"; }

# Locale and editor
export LANG='en_GB.UTF-8'
export LANGUAGE='en_GB.UTF-8'
export EDITOR='vim'

# Sudo replacement aliases
alias svim='sudo vim'
alias snano='sudo nano'
alias ipt='sudo iptables'
alias ip6t='sudo ip6tables'
alias iptables='sudo iptables'
alias runlevel='sudo /sbin/init'
alias yum='sudo yum'
alias rpm='sudo rpm'
alias kill='sudo kill'
alias killall='sudo killall'
alias service='sudo service'
alias apt-get='sudo apt-get'
alias dpkg='sudo dpkg'
alias aptitude='sudo aptitude'
alias cps='sudo cp'
alias update="sudo aptitude update"
alias install="sudo aptitude install"
alias reinstall="sudo aptitude reinstall"
alias upgrade="sudo aptitude safe-upgrade"
alias remove="sudo aptitude remove"
alias purge='sudo aptitude purge'
#alias pip='sudo pip'

# Server/Users specific aliases and functions
alias flex='~/Flexget/bin/flexget'
alias res='screen -dr tty'
alias sirssi='screen -dmS ircs irssi'
alias irc='screen -rD ircs'
alias free="free -m"
alias nr="sudo service nginx reload"
alias msm='sudo -H -u minecraft msm'

