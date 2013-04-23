 cd ~
mkdir ~/tmp
cd ~/tmp
wget http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tgz
tar zxvf Python-2.7.3.tgz
cd Python-2.7.3
./configure --prefix=$HOME/bin/python27
make
make install
source ~/.bashrc
echo $PATH
