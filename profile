# Source global definitions
if [ -f /etc/profile ]; then
  . /etc/profile
fi
# if running bash
if [ -n "$BASH_VERSION" ]; then
  # Looks best on a terminal with black background.....
  echo "Welcome $USER... We've been expecting you!"
  date
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
