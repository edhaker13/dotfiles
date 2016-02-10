# Editing

if [[ ! "$SSH_TTY" ]] && is_osx; then
  export EDITOR='mvim'
  export LESSEDIT='mvim ?lm+%lm -- %f'
else
  export EDITOR='vim'
fi

export VISUAL="$EDITOR"
alias se="sudo $EDITOR"
alias e="$EDITOR"
alias ev="e $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias es="e $DOTFILES"

# Stop tilde expansion by bash-completion
function _expand() { :; }
