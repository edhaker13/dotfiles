Dotfiles
========
This repository includes all of my custom configs and dotfiles.  They should be cloned to
your home directory so that the path is `~/dotfiles/`.  The included setup
script creates symlinks from your home directory to the files which are located
in `~/dotfiles/`. There are also some other files from nginx and flexget which I dont know if they work.

The setup script is smart enough to back up your existing dotfiles into a
`~/dotfiles_old/` directory if you already have any dotfiles of the same name as
the dotfile symlinks being created in your home directory.

It will also symlink any other file configured in the script such as flexget. 
But really it doesnt like going to another user's folder.

So, to recap, the install script will:

1. Back up any existing dotfiles in your home directory to `~/dotfiles_old/`
2. Create symlinks to the dotfiles in `~/dotfiles/` in your home directory.


Installation
------------

``` bash
# clone repo, place it in home
git clone git@github.com:edhaker13/dotfiles.git ~/dotfiles
# change into repo
cd dotfiles
# make executables and run
chmod a+x mklinks.sh
./mklinks.sh
# to update an already existing repo do
cd ~/dotfiles && git pull origin master
# if you want it to pull update every so often just make a cronjob or 
# use post-receive hook (this I don't know how in github)
crontab -e
# Paste this line, the */5 means every five mins, change this to what you want
*/5 * * * * cd ~/dotfiles && git -q pull origin master
```
Configurations for...
---------------------
I have configuration files for different programs like nano, bash or irssi.

Here is a full list:

1. IRSSI: scripts, themes, and settings.
2. Bash: user configuration, functions, aliases, etc.
3. Flexget: config file, additional plugins. Files need to be manually linked.
4. Lighttpd: server config, vhosts, mime types, included configs.
5. Nano: settings, aliases, active sintax highlighting.
6. Nginx: server config, vhosts, active vhosts, etc. Droppped.
7. Screen: settings, mainly utf-8 on and support scrolling.
8. SSH: config for different servers, key to use, aliases.
9. Vim: same as nano, keep it just in case. I don't use vim.

