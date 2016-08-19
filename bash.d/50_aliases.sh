#-------------------------------------------------------------
# Check if $1 exists and preload it if it does
#-------------------------------------------------------------

function exists()
{
    hash "$1" &> /dev/null;
}

#-------------------------------------------------------------
# Default program option aliases
#-------------------------------------------------------------

alias df='df -h'
alias free='free -m'
alias ls='ls --color -Fh'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias wget='wget --content-disposition'
alias back='cd "$OLDPWD"'
alias grep='grep --color'

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
# Spelling typos - highly personal and keyboard-dependent :-)
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
  alias netstat='sudo netstat'
  exists dpkg && alias dpkg='sudo dpkg'
  exists yum  && alias yum='sudo yum'
  exists rpm  && alias rpm='sudo rpm'
  exists apt-get && alias apt-get='sudo apt-get'
  exists aptitude && alias aptitude='sudo aptitude'
  exists service  && alias service='sudo service' || alias service='sudo /etc/init.d/$1 ${@:2}'
fi
