# .bashrc
#-------------------------------------------------------------
# Source global definitions
#-------------------------------------------------------------

if [ -f /etc/bash.bashrc ]; then
  . /etc/bash.bashrc
fi

#-------------------------------------------------------------
# Safe checks
#-------------------------------------------------------------

# Message too long fix
if [ "$TERM" != "dumb" ]; then
 test -s ~/.bashrc-local && . ~/.bashrc-local
fi
# If not running interactively exit
[ -z '$PS1' ] && return
[[ $- != *i* ]] && return

#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------

function my_ip()
{ # Get IP adresses.
  MY_IP=$(/sbin/ip addr show venet0 | awk '/inet/ { print $2 } ' | \sed -e s/addr://)
}

function ii()
{ # Get current host related info.
  echo "\n${RED}You are logged on ${LPURPLE}$HOSTNAME"
  echo "\n${RED}Additionnal information:${WHITE} " ; uname -a
  echo "\n${RED}Users logged on:${WHITE} " ; w -h
  echo "\n${RED}Current date :${WHITE} " ; date
  echo "\n${RED}Machine stats :${WHITE} " ; uptime
  echo "\n${RED}Memory stats :${WHITE} " ; free
  my_ip 2>&- ;
  echo "\n${RED}Local IP Address :${WHITE} " ; echo ${MY_IP:-'Not connected'}
  echo "\n${RED}Open connections :${WHITE} "; netstat -pan --inet;
  echo
}

#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------

function repeat()
{ # Repeat n times command.
  local i max
  max=$1; shift;
  for ((i=1; i <= max ; i++)); do  # --> C-like syntax
    eval "$@";
  done
}

function ask()
{ # Ask a yes or no question.
  echo -n "$@" '[y/n] ' ; read ans
  case "$ans" in
    y*|Y*) return 0 ;;
    *) return 1 ;;
  esac
}

function exists()
{ # Check if a program exists in PATH, preload if true
  hash "$@" &>/dev/null;
}

function dlzip()
{ # Download, extract and remove zip from url. dlzip <url> [unzip args*]
  exists unzip || (echo 'unzip not found'; return 1);
  wget  $1 -qO $tmp;
  unzip $tmp ${@:2};
  rm $tmp;
}

#-------------------------------------------------------------
# Basic options
#-------------------------------------------------------------
export HISTCONTROL=ignoredups:ignorespace:ignoreboth
export COLORFGBG='default;default'
# leave some commands out of history log
export HISTIGNORE='&:??:[ ]*:clear:exit:logout'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT='%H:%M > '

# Sets up history length
export HISTSIZE=10000
export HISTFILESIZE=50000

# Locale and editor
export LANG='en_GB.UTF-8'
export LANGUAGE='en_GB.UTF-8'
exists vim && export EDITOR='vim' && export EDITOR='vi'

#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

# Disable options:
set -o notify
set -o noclobber
set -o ignoreeof

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
complete -cf sudo  # Enable sudo tab completion

# Put some colors in ls
export CLICOLOR=1
export LSCOLORS=ExFxCxDxCxegedabagacad

#-------------------------------------------------------------
# Default program option aliases
#-------------------------------------------------------------

alias df='df -h'
alias free='free -m'
alias ls='ls -h --color=auto'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias wget='wget --content-disposition'
alias back='cd $OLDPWD'
alias grep='grep --color=auto'

#-------------------------------------------------------------
# Handy aliases
#-------------------------------------------------------------

alias h='cd'
alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../..'
alias bye='exit'

#-------------------------------------------------------------
# Handy file conversion aliases
#-------------------------------------------------------------

exists dos2unix || alias dos2unix="perl -pi -e 's/\r\n/\n/;'"
exists unix2dos || alias unix2dos="perl -pi -e 's/\n/\r\n/;'"
exists bomstrip || alias bomstrip="sed -i -s -e '1s/^\xef\xbb\xbf//'"

#-------------------------------------------------------------
# Prompt
#-------------------------------------------------------------

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
case $TERM in
  xterm* | rxvt)
    PS1="\[\033]0;\u@\h: \w\007\]"
    ;;
  *)
    ;;
esac
export PS1="${CYAN}[${LGREEN}\u${LPURPLE}@${LRED}\H ${YELLOW}\w${CYAN}]${LGRAY}> ${WHITE}"
export PS2="${GREEN}->"
export PS3="${LPURPLE}*?"

#-------------------------------------------------------------
# Spelling typos - highly personnal and keyboard-dependent :-)
#-------------------------------------------------------------

alias cs='cd'
alias vf='cd'
alias vd='cd'
alias moer='more'
alias moew='more'
alias kk='ll'
alias sduo='sudo'

#-------------------------------------------------------------
# Sudo replacement aliases
#-------------------------------------------------------------

if [ $UID -ne 0 ]; then
  alias ipt='sudo iptables'
  alias ip6t='sudo ip6tables'
  alias iptables='sudo iptables'
  alias kill='sudo kill'
  alias killall='sudo killall'
  exists dpkg && alias dpkg='sudo dpkg'
  exists yum  && alias yum='sudo yum'
  exists rpm  && alias rpm='sudo rpm'
  exists apt-get && alias apt-get='sudo apt-get'
  exists aptitude && alias aptitude='sudo aptitude'
  exists service  && alias service='sudo service' || alias service='sudo /etc/init.d/$1 ${@:2}'
  exists vim  && alias svim='sudo vim'
  exists nano && alias snano='sudo nano'
fi

#-------------------------------------------------------------
# Apt-get/Aptitude shorteners. Apt-get has preference
#-------------------------------------------------------------

if exists aptitude; then
  alias update='aptitude update'
  alias install='aptitude install'
  alias reinstall='aptitude reinstall'
  alias upgrade='aptitude safe-upgrade'
  alias remove='aptitude remove'
  alias purge='aptitude purge'
fi

if exists apt-get; then
  alias update='apt-get update'
  alias install='apt-get install'
  alias reinstall='apt-get install --reinstall'
  alias upgrade='apt-get dist-upgrade'
  alias remove='apt-get remove'
  alias purge='apt-get purge'
fi

#-------------------------------------------------------------
# Server specific aliases and functions
#-------------------------------------------------------------

if [[ -a "$HOME/Flexget/bin/flexget" ]];then
  alias flex='~/Flexget/bin/flexget'
fi

if exists irssi; then
  if exists tmux; then
    alias irc='tmux attach-session -t irc || tmux new-session -s irc'
    alias sirssi='irc'
  elif exists screen; then
    alias sirssi='screen -dmS ircs irssi'
    alias irc='screen -rD ircs'
  fi
fi

if exists nginx; then
  alias nr='service nginx reload'
  alias nt='service nginx configtest'
  alias nrr='service nginx restart'
fi

if exists rtorrent; then
  if exists tmux; then
    alias torr='tmux attach-session -t rtord || tmux new-session -s rtord'
    alias tord='torr'
  elif exists screen; then
    alias tord='screen -dmS rtord rtorrent'
    alias torr='screen -rD rtord'
  fi
fi

if exists msm; then
  alias msm='sudo -H -u minecraft msm'
  alias mc='sudo -H -u minecraft'
  alias mcl='\sudo su minecraft'
fi

#-------------------------------------------------------------
# PyEnv
#-------------------------------------------------------------

if [[ -a "$HOME/.pyenv" ]];then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

#-------------------------------------------------------------
# Promptline
#-------------------------------------------------------------

if [[ -f "$HOME/dotfiles/promptline.sh" ]]; then
  . "$HOME/dotfiles/promptline.sh"
fi

#-------------------------------------------------------------
# Print (mis)fortune
#-------------------------------------------------------------

if exists fortune; then
  echo -en ${WHITE:2:10}
  if exists cowsay; then
    fortune -a -s | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf | head -n1)
  else
    fortune -a -s
  fi
fi

#-------------------------------------------------------------
# Start tmux on login
#-------------------------------------------------------------

if exists tmux; then
  if [[ -z "$TMUX" ]]; then
    if tmux has-session; then
      exec tmux attach-session -t ssh
    else
      exec tmux new-session -s ssh
    fi
  fi
fi

#-------------------------------------------------------------
