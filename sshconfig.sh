# Specify different options so they don't need to go in cmd
# For edhaker.info Git server
host edhaker
user git
hostname nemu.edhaker.info
port 666
PreferredAuthentications publickey
identityfile ~/.ssh/id_rsa

# For Checacorp.cz.cc, just in case its the same server really
host checacorp.cz.cc
user git
port 666
PreferredAuthentications publickey
identityfile ~/.ssh/id_rsa

# For github.com
host github.com
PreferredAuthentications publickey
identityfile ~/.ssh/id_rsa