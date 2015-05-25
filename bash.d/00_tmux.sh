#-------------------------------------------------------------
# Start tmux on login. Unnecessary if shell is tmux
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
