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
# Start tmux on login. Unnecessary if shell is tmux
#-------------------------------------------------------------

if hash tmux &>/dev/null; then
  if [[ -z "$TMUX" ]]; then
    if tmux has-session -t ssh &>/dev/null; then
      exec tmux attach-session -t ssh
    else
      exec tmux new-session -s ssh
    fi
  fi
fi

#-------------------------------------------------------------
