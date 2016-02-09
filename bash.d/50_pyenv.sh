#-------------------------------------------------------------
# PyEnv
#-------------------------------------------------------------

if [[ -a "$HOME/.pyenv" ]];then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  if [[ -a "$PYENV_ROOT/plugins/pyenv-virtualenv" ]]; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi
