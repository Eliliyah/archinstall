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

confirm "Are you ready to keep going?" $(echo "Say your prayers.")

#Chroot into the new root
arch-chroot /mnt
ls
confirm "Did you make it to the chroot?" $(echo "Cool.")

#Set the time
loadkeys us
timedatectl --no-ask-password set-timezone America/New_York
timedatectl set-ntp true
systemctl enable systemd-timesyncd.service
locale-gen

#Install important packages
pacman -Syu --noconfirm
pacman -S networkmanager dhclient pacman-contrib curl dhcpcd rsync --needed --noconfirm
pacman -S linux-zen linux-lts --noconfirm
confirm "Did everything go as planned?" $(echo "Don't worry. There's still time to break everything.")

#Check the time again
timedatectl set-ntp true
timedatectl status 
confirm "Did you check the time?" $(echo "We're going to keep checking.")

#Clone into the install directory
git clone https://github.com/Eliliyah/archinstall.git
cd archinstall
chmod +x part2.sh
confirm "Are we cloned?" $(echo "Excellent. Time to sudo EDITOR=nano visudo and uncomment the wheel group.")

#Set the root password
passwd
confirm "Did you set the root password?" $(echo "Excellent. You haven't broken it. Yet.")

#add yourself as a user
useradd -m -G wheel -s /bin/bash ellie
passwd ellie
echo "ellie ALL=(ALL)ALL">> /etc/sudoers
confirm "Do you exist now?" $(echo "Are you sure you want to?")

#Create the backup directory and move files
mkdir /etc/backupfolder
mv /etc/locale.gen /etc/backupfolder
mv /etc/pacman.d/mirrorlist /etc/backupfolder
mv /etc/pacman.conf /etc/backupfolder
mv /etc/mkinitcpio.conf /etc/backupfolder
confirm "Did the files backup successfully?" $(echo "Excellent. You haven't broken it. Yet.")

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
confirm "Did all the files copy successfully?" $(echo "Whew!")

#Install Extras
cd/tmp
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh
confirm "Do you really think you're going to need that?" $(echo "Whatever you say, Ellie.")

#Enable system services
reflector
systemctl enable NetworkManager
systemctl enable systemd-timesyncd.service
systemctl enable gdm.service
systemctl enable dhcpcd
confirm "Did system services enable?" $(echo "Okay, time for a deep breath.")

#Run mkinitcpio 
mkinitcpio -p linux
confirm "Did it work?" $(echo "Thank God.")

#Install grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
confirm "Are you ready to get out of here?" $(echo "Same.")
