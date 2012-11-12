#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles # dotfiles directory
olddir=~/dotfiles_old # old dotfiles backup directory
files="bashrc vimrc vim screen ssh private" # list of files/folders to symlink in homedir
nginx="nginx.conf sites-available sites" # need linkin to nginx

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# set permissions to group rw, for nginx and link.
for file in $nginx; do
echo "Setting group r+w"
  mv /etc/ningx/$file ~/nginx_old/
  chmod 775 $dir/$file
  echo "Now linking to /etc/ningx/"
  ln -fs $dir/$file /etc/nignx/
  echo "Linked $file"
done

# Individual files linking, flexget config,
echo "Now SymLinking Individual files"
ln -fs $dir/config.yml /var/lib/deluge/.flexget/
echo "Flexget config linked"
chmod a+x $dir/snap
ln -fs $dir/snap $HOME/bin/
echo "linked snapshot script"

