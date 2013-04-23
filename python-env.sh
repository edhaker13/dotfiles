#!/bin/bash
cd ~/tmp
wget http://peak.telecommunity.com/dist/ez_setup.py
python ez_setup.py
easy_install pip
pip install virtualenv
virtualenv $HOME/env
#Switch to virtualenv
source $HOME/env/bin/activate

