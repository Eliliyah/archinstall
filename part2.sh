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

timedatectl set-timezone America/New_York
timedatectl set-ntp true

#Install important packages
pacman -Syu --noconfirm
pacman -S networkmanager dhclient pacman-contrib curl dhcpcd rsync --needed --noconfirm
pacman -S linux-zen linux-lts --noconfirm
confirm "Did everything go as planned?" 

#Set the root password
passwd
confirm "Did you set the root password?" 

#add yourself as a user
useradd -m -G wheel -s /bin/bash ellie
passwd ellie
echo "ellie ALL=(ALL)ALL">> /etc/sudoers
confirm "Do you exist now?" 

#Create the backup directory and move files
mkdir /etc/backupfolder
mv /etc/locale.gen /etc/backupfolder
mv /etc/pacman.d/mirrorlist /etc/backupfolder
mv /etc/pacman.conf /etc/backupfolder
mv /etc/mkinitcpio.conf /etc/backupfolder
confirm "Did the files backup successfully?" 

#Copy files
cp /archinstall/hostname /etc/hostname
cp /archinstall/locale.gen /etc/locale.gen
cp /archinstall/mirrorlist /etc/pacman.d/mirrorlist
cp /archinstall/pacman.conf /etc/pacman.conf
cp /archinstall/locale.conf /etc/locale.conf
cp /archinstall/endeavouros-mirrorlist /etc/pacman.d/endeavouros-mirrorlist
cp /archinstall/vconsole.conf /etc/vconsole.conf
cp /archinstall/mkinitcpio.conf /etc/mkinitcpio.conf
ls /etc/backupfolder
confirm "Did all the files copy successfully?" 

#Install Extras
cd/tmp
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh
confirm "Do you really think you're going to need that?" 

#Enable system services
reflector
systemctl enable NetworkManager
systemctl enable systemd-timesyncd.service
systemctl enable dhcpcd
confirm "Did system services enable?" 

#Install gnome packages
pacman -S wayland xorg-xwayland wayland-protocols libva
pacman -S gdm gnome-shell 
pacman -S gnome-terminal --needed gnome-desktop cinnamon-desktop gnome-control-center gnome-system-monitor gnome-tweaks  gnome-color-manager gnome-usage gnome-screenshot gnome-keyring gnome-nettool gnome-calculator 
systemctl enable gdm.service
cp /archinstall/postinstall.sh /home/ellie/Downloads 
chmod +x /home/ellie/Downloads/postinstall.sh

#Run mkinitcpio 
mkinitcpio -p linux
mkinitcpio -p linux-zen
mkinitcpio -p linux-lts
confirm "Did it work?" 

#Install grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
confirm "Are you ready to get out of here?" 
exit 
