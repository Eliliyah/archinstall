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
#Generate locales
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8">> /etc/locale.gen
locale-gen 
confirm "Did locales generate?"
echo "LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_MONETARY=en_US.UTF-8
LC_PAPER=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
LANGUAGE=en_US.UTF-8">> /etc/locale.conf
echo "KEYMAP=us
FONT=Lat2-Terminus16">> /etc/vconsole.conf
echo "ellie">> /etc/hostname

#Set the root password
passwd

#add yourself as a user
useradd -m -G wheel -s /bin/bash ellie
passwd ellie
echo "ellie ALL=(ALL)ALL">> /etc/sudoers

#Install important packages
pacman -Syu --noconfirm
pacman -S networkmanager dhclient pacman-contrib curl dhcpcd rsync opera gedit konsole fish --noconfirm

#Move and copy files
mkdir /etc/backupfolder
mv /etc/pacman.d/mirrorlist /etc/backupfolder
mv /etc/pacman.conf /etc/backupfolder
mv /etc/mkinitcpio.conf /etc/backupfolder
cp /archinstall/mirrorlist /etc/pacman.d/mirrorlist
cp /archinstall/pacman.conf /etc/pacman.conf
cp /archinstall/endeavouros-mirrorlist /etc/pacman.d/endeavouros-mirrorlist
cp /archinstall/mkinitcpio.conf /etc/mkinitcpio.conf
ls /etc/pacman.d


#Install gnome packages
pacman -S wayland-protocols libva --noconfirm
pacman -S meson ninja  --noconfirm
pacman -S nemo --noconfirm
chmod +x postinstall.sh


#Enable system services
reflector
systemctl enable NetworkManager
systemctl enable dhcpcd


#Run mkinitcpio 
mkinitcpio -p linux
mkinitcpio -p linux-zen
mkinitcpio -p linux-lts


#Install grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
confirm "All good?" 
