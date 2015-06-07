# Where the magic happens.
export DOTFILES=~/.dotfiles

# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH

#-------------------------------------------------------------
# Safe checks
#-------------------------------------------------------------

# Message too long fix
if [ "$TERM" != "dumb"  ]; then
  test -s ~/.bashrc-local && . ~/.bashrc-local
fi

# If not running interactively exit
[ -z '$PS1'  ] && return
[[ $- != *i*  ]] && return

#-------------------------------------------------------------

# Source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$DOTFILES/bash.d/$1.sh"
  else
    for file in $DOTFILES/bash.d/*; do
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  $DOTFILES/bin/dotfiles "$@" && src
}

src
