#!/bin/bash

USER=myuser # CHANGE THIS
VIMRC_LOCAL=/etc/vim/vimrc.local

apt-get update
apt-get -y dist-upgrade
sudo apt install vim

# Setup VIM
echo "syn on" > $VIMRC_LOCAL
echo "set background=dark" >> $VIMRC_LOCAL
echo "colorscheme elflord" >> $VIMRC_LOCAL

# Enable ssh for remote management
systemctl enable ssh
systemctl start ssh

# Change PermitRootLogin to no
####################

# Change umask to more secure setting
sed -i "s/UMASK[\t ]*022/UMASK    027/g" /etc/login.defs

# Add user
useradd -m $USER
usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio $USER

# TO DO, CHANGE USER PASSWORD

# Remove nopassword sudoers
rm /etc/sudoers.d/010_pi-nopasswd

# Set auto logout to 10 minutes
echo "TMOUT=600" > /etc/profile.d/auto_logout.sh
echo "readonly TMOUT" >> /etc/profile.d/auto_logout.sh
echo "export TMOUT" >> /etc/profile.d/auto_logout.sh
