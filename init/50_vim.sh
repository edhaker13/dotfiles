# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

# Download Vim plugins.
if hash vim &>/dev/null; then
  export APP_PATH="$DOTFILES/vendor/spf13-vim" && $DOTFILES/vendor/spf13-vim/bootstrap.sh
fi
