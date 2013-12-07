# Source global definitions
if [ -f /etc/profile ]; then
  . /etc/profile
fi
# Looks best on a terminal with black background.....
echo -e "Welcome $USER... We've been expecting you!"
date
# Print awesomeness
if hash fortune 2>/dev/null; then
  echo -en '\033[0;36m'
  fortune -a -s | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf | head -n1)
  echo -en '\033[0;37m'
fi
# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
#Start SSH Keychain
#Let re-use ssh-agent and/or gpg-agent between logins
#/usr/bin/keychain $HOME/.ssh/id_rsa
#source $HOME/.keychain/$HOSTNAME-sh

#Clear when not logged in
#/usr/bin/keychain --clear $HOME/.ssh/id_rsa
### End-Keychain ###
