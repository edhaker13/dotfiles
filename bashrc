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
# Basic options
#-------------------------------------------------------------
export HISTCONTROL=ignoredups:ignorespace:ignoreboth
export COLORFGBG='default;default'
# leave some commands out of history log
export HISTIGNORE='&:??:[ ]*:clear:exit:logout'
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

# Put some colours in ls
export CLICOLOR=1
export LSCOLORS=ExFxCxDxCxegedabagacad

#-------------------------------------------------------------
# Apt-get/Aptitude short-cuts. Apt-get has preference
#-------------------------------------------------------------

if exists apt-get; then
  alias update='apt-get update'
  alias install='apt-get install'
  alias reinstall='apt-get install --reinstall'
  alias upgrade='apt-get upgrade'
  alias dist-upgrade='apt-get dist-upgrade'
  alias remove='apt-get remove'
  alias purge='apt-get purge'
elif exists aptitude; then
  alias update='aptitude update'
  alias install='aptitude install'
  alias reinstall='aptitude reinstall'
  alias upgrade='aptitude safe-upgrade'
  alias dist-upgrade='aptitude upgrade'
  alias remove='aptitude remove'
  alias purge='aptitude purge'
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
  eval "$(pyenv virtualenv-init -)"
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
