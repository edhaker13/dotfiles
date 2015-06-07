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
