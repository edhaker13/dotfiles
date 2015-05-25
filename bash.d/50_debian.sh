# Abort if not a debian OS
is_debian || return 1

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
