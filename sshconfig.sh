# Specify different options so they don't need to go in cmd
# For edhaker.info Git server
host edhaker
user git
hostname nemu.edhaker.info
port 666
PreferredAuthentications publickey
identityfile ~/.ssh/key_bak

# For Checacorp.com
host yuno
user edhaker13
hostname yuno.checacorp.com
port 666
PreferredAuthentications publickey
identityfile ~/.ssh/id_rsa

# For github.com
host github
user git
hostname github.com
PreferredAuthentications publickey
identityfile ~/.ssh/key_bak
