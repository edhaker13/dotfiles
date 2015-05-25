# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

# Download Vim plugins.
if exists vim; then
  vim +PlugUpgrade +PlugUpdate +qall
fi
