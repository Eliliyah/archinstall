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

confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

#Use timedatectl(1) to ensure the system clock is accurate:
loadkeys us 
timedatectl --no-ask-password set-timezone America/New_York
timedatectl set-ntp true
timedatectl status
confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

#Partition the drive
sgdisk --zap-all /dev/sda

sgdisk --clear \
         --new=1:0:+550MiB --typecode=1:ef00 --change-name=1:EFI \
         --new=2:0:+1GiB   --typecode=2:8200 --change-name=2:swap \
         --new=3:0:0       --typecode=3:8300 --change-name=3:system \
           /dev/sda
fdisk -l 

confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

#Format the new partitions
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.btrfs /dev/sda3
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
fdisk -l 
confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

#Install the base system
pacstrap /mnt base linux linux-firmware
pacstrap /mnt dhcpcd linux-zen base-devel btrfs-progs iw gptfdisk zsh terminus-font intel-ucode snapper grub dosfstools man-db man-pages nano usbutils which neofetch fish efibootmgr reflector perl perl-timedate iwd git systemd grub-btrfs

genfstab -L -p /mnt >> /mnt/etc/fstab

#Chroot into the new root
arch-chroot /mnt
ls
confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

#Set the time
loadkeys us
timedatectl --no-ask-password set-timezone America/New_York
timedatectl set-ntp true
systemctl enable systemd-timesyncd.service
locale-gen
timedatectl status 
confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

#Create the backup directory
mkdir /etc/backup
ls /etc
confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

#Install important packages
pacman -Syu --noconfirm
pacman -S networkmanager dhclient pacman-contrib curl dhcpcd rsync --needed --noconfirm
pacman -S linux-zen linux-lts --noconfirm
pacman -S git wayland xorg-xwayland gdm wayland-protocols qt5-wayland libva xorg xdg-user-dirs gnome-shell nemo fish opera

confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

#Check the time again
timedatectl set-ntp true
timedatectl status 
confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

#Clone into the install directory
git clone https://github.com/Eliliyah/archinstall.git
cd archinstall
chmod +x part2.sh
ls
confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

#Edit the sudo file
sudo EDITOR=nano visudo
