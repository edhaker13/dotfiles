Dotfiles
========
This repository includes all of my custom configs and dotfiles.  They should be cloned to
your home directory so that the path is `~/dotfiles/`.  The included setup
script creates symlinks from your home directory to the files which are located
in `~/dotfiles/`. There are also some other files from nginx and flexget which I dont know if work.

The setup script is smart enough to back up your existing dotfiles into a
`~/dotfiles_old/` directory if you already have any dotfiles of the same name as
the dotfile symlinks being created in your home directory.

It will also symlink any other file cofigured in the script such as flexget.

So, to recap, the install script will:

1. Back up any existing dotfiles in your home directory to `~/dotfiles_old/`
2. Create symlinks to the dotfiles in `~/dotfiles/` in your home directory
3. Backup any nginx.conf that it finds to '~/nginx_old/'
4. Create symlinks to the specified files
5. Create symlink to flexget config.

Installation
------------

``` bash
git clone git://github.com/michaeljsmalley/dotfiles ~/dotfiles
cd ~/dotfiles
chmod a+x mklinks.sh
./mklinks.sh
```