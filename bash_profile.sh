# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
# Looks best on a terminal with black background.....
echo -e "Welcome Edhaker... We've been expecting you"
date
# Print awesomeness
if which fortune >/dev/null; then
    echo -en '\033[0;36m'
          fortune -a -s | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf | head -n1)
          echo -en '\033[0;37m'
fi