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
confirm "Are you ready to keep going?" 

#Generate locales
locale-gen 
confirm "Did locales generate?"
echo "en_US.UTF-8 UTF-8">> /etc/locale.gen
echo "ellie">> /etc/hostname
echo "KEYMAP=us
FONT=Lat2-Terminus16">> /etc/vconsole.conf


#Set Timezone
timedatectl set-timezone America/New_York
timedatectl set-ntp true
echo "LANGUAGE=en_US.UTF-8
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
LANG=en_US.UTF-8">> /etc/locale.conf
timedatectl status
confirm "Did the time set correctly?" 

#Install LTS kernel
pacman -S linux-lts --noconfirm

#Install important packages
pacman -Syu --noconfirm
pacman -S networkmanager dhclient pacman-contrib curl dhcpcd rsync opera --noconfirm
confirm "Ready to enter the root and user passwords?" 

#Set the root password
passwd

#add yourself as a user
useradd -m -G wheel -s /bin/bash ellie
passwd ellie
echo "ellie ALL=(ALL)ALL">> /etc/sudoers
confirm "Do you exist now?" 

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
confirm "Did all the files copy successfully?" 

#Install Extras
cd/tmp
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh
confirm "Do you really think you're going to need that?" 

#Install gnome packages
pacman -S wayland xorg-xwayland wayland-protocols libva --noconfirm
pacman -S gdm gnome-shell --noconfirm
pacman -S gnome-terminal --needed gnome-desktop cinnamon-desktop gnome-control-center gnome-system-monitor gnome-tweaks  gnome-color-manager gnome-usage gnome-screenshot gnome-keyring gnome-nettool gnome-calculator --noconfirm
pacman -S nemo --noconfirm
chmod +x postinstall.sh
confirm "Are we gnomed?" 

#Enable system services
reflector
systemctl enable NetworkManager
systemctl enable dhcpcd
systemctl enable gdm.service
confirm "Did system services enable?" 

#Run mkinitcpio 
mkinitcpio -p linux
mkinitcpio -p linux-zen
mkinitcpio -p linux-lts
confirm "Did it work?" 

#Install grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
confirm "All good?" 
