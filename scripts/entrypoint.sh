#!/bin/sh

# Modify the prompt to show this is a dbmint system
echo "export PS1=\"bn_env:\W# \"" >> /etc/profile

echo "Welcome to the bnENV terminal!" > /etc/motd
echo >> /etc/motd
echo 'Users are recommended to VNC into this system to access.' >> /etc/motd
echo >> /etc/motd
echo 'You may change this message by editing /etc/motd.' >> /etc/motd

# Setup rom build repo use with lucky's agbcc (https://github.com/dism-exe/bn6f/blob/master/INSTALL.md)
#mkdir /root/src
#cd /root/src
#git clone https://github.com/luckytyphlosion/agbcc -b new_layout_with_libs

cd /mnt/$AGBCC_REPO_NAME
make
make install prefix=/mnt/$ROM_BUILD_REPO_NAME

cd /mnt/$ROM_BUILD_REPO_NAME/tools/gbagfx
make

# Make sure to run this after each make clean
cd /mnt/$ROM_BUILD_REPO_NAME/
make assets

# Build the ROM
make -j$(nproc) 
mkdir -p /mnt/built
mv $ROM_BUILD_REPO_NAME.gba /mnt/built/$ROM_BUILD_REPO_NAME.gba

# For SSH:
ssh-keygen -A
/usr/sbin/sshd -D &

/startup.sh

# This should reflect the is_persistent file having Yes or No.

# If Yes:
# Stay on indefinitely 
# tail -f /dev/null

# If No:
# Just run the app
# . /opt/venv/bin/activate && python3 /app/dbmint.py $@
