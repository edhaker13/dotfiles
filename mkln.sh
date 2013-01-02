#!/bin/bash
############################
# sudoln.sh
# This script creates symlinks from the their respective directories to any desired dotfiles in ~/dotfiles.
# Wouldnt work kept for historical purposes
############################
########## Variables

dir=~/dotfiles # dotfiles directory
olddir=~/dotfiles_old # old dotfiles backup directory
files="nginx.conf sites-available sites" # need linkin to nginx
ndir=/etc/nginx
# move any existing files in $ndir to nginx_old
# set permissions to group rw, for nginx and link.
for file in $files; do
  mv $ndir/$file ~/nginx_old/
 echo "Setting group Read"
  chmod 755 $dir/$file
 echo "Now linking $file to $ndir"
  ln -fs $dir/$file $ndir
done

# Individual files linking, flexget config,
echo "Now Symlinking Individual files"
ln -fs $dir/config.yml /var/lib/deluge/.flexget/
echo "Flexget config linked"
chmod a+x $dir/snap
ln -fs $dir/snap /usr/local/bin/
echo "linked snapshot script to /usr/local/bin"
