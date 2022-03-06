#!/usr/bin/bash

#FUNCTIONS GO HERE

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "aborted"; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
example-function() {
    echo "Excellent. You haven't broken it. Yet."
}

#Enable system services
systemctl enable NetworkManager
systemctl enable sddm
systemctl enable power-profiles-daemon 
systemctl enable bluetooth
systemctl enable preload
confirm "Did system services enable?" 

#Configure journal
echo "Storage=persistent">> /etc/systemd/journald.conf

#Enable SysRq key
echo "kernel.sysrq = 1" >> /etc/sysctl.d/99-sysctl.conf

#Configure zram
pacman -S zram-generator
cp /archinstall/zram-generator.conf /etc/systemd/zram-generator.conf

#Generate the initramfs
mkdir /etc/backupfolder
mv /etc/mkinitcpio.conf /etc/backupfolder
cp /archinstall/mkinitcpio.conf /etc/mkinitcpio.conf
nano /etc/mkinitcpio.conf
mkinitcpio -p linux
mkinitcpio -p linux-zen
