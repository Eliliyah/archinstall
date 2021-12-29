#!/usr/bin/bash

#FUNCTIONS GO HERE

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer Y or N.";;
        esac
    done
}
example-function() {
    echo "$2"
}

confirm "Are you ready to do this?"

#Use timedatectl(1) to ensure the system clock is accurate:
loadkeys us 
timedatectl set-timezone America/New_York
timedatectl set-ntp true

#Partition the drive
sgdisk --zap-all /dev/sda

confirm "Did it zap?" 

sgdisk --clear \
         --new=1:0:+550MiB --typecode=1:ef00 --change-name=1:EFI \
         --new=2:0:+1GiB   --typecode=2:8200 --change-name=2:swap \
         --new=3:0:0       --typecode=3:8300 --change-name=3:system \
           /dev/sda

#Format the new partitions
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.btrfs -f /dev/sda3
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
fdisk -l 
confirm "Partitions look okay?" 

#Install the base system
pacstrap /mnt base linux linux-firmware
pacstrap /mnt dhcpcd linux-zen base-devel btrfs-progs iw gptfdisk zsh terminus-font intel-ucode snapper grub dosfstools man-db man-pages nano usbutils which neofetch python efibootmgr efitools efivar reflector perl perl-timedate iwd git systemd grub-btrfs xorg xdg-user-dirs 
confirm "Was install successful?" 

#Copy script to the new system
mkdir /mnt/archinstall
mv /archinstall/part2.sh /mnt/archinstall
chmod +x /mnt/archinstall/part2.sh
mv /archinstall/part3.sh /mnt/archinstall
chmod +x /mnt/archinstall/part2.sh
mv /archinstall/postinstall.sh /mnt/archinstall
mv /archinstall/hostname /mnt/archinstall
mv /archinstall/locale.gen /mnt/archinstall
mv /archinstall/mirrorlist /mnt/archinstall
mv /archinstall/pacman.conf /mnt/archinstall
mv /archinstall/locale.conf /mnt/archinstall
mv /archinstall/endeavouros-mirrorlist /mnt/archinstall
mv /archinstall/vconsole.conf /mnt/archinstall
mv /archinstall/mkinitcpio.conf /mnt/archinstall
ls /mnt/archinstall
confirm "Did the files make it over?" 

genfstab -L -p /mnt >> /mnt/etc/fstab
confirm "Ready to chroot?" 

#Chroot into the new root
arch-chroot /mnt
cd archinstall
ls
timedatectl status

