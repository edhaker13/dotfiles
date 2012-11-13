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
However for the second set of files you will need to run it as sudo because of the file permissions.

So, to recap, the install script will:

1. Back up any existing dotfiles in your home directory to `~/dotfiles_old/`
2. Create symlinks to the dotfiles in `~/dotfiles/` in your home directory.
3. Backup any nginx.conf that it finds to '~/nginx_old/'
4. Create symlinks to the specified files, overwriting config.yml

Installation
------------

``` bash
# clone repo placint it home
git clone git@github.com:edhaker13/dotfiles.git ~/dotfiles
# change into repo
cd dotfiles
# make executables and run
chmod a+x mklinks.sh
./mklinks.sh
chmod a+x mkln.sh
sudo ./mkln.sh
# to update an already existing repo do
cd ~/dotfiles && git pull origin master
# if you want it to pull update every so often just make a cronjob or 
# use post-receive hook (this I don't know how in github)
crontab -e
# Paste this line, the */5 means every five mins, change this to what you want
*/5 * * * * cd ~/dotfiles && git -q pull origin master
```