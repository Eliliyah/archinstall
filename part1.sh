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
pacstrap /mnt dhcpcd linux-zen base-devel btrfs-progs iw gptfdisk zsh terminus-font intel-ucode snapper grub dosfstools man-db man-pages nano usbutils util-linux which neofetch python efibootmgr efitools efivar reflector perl perl-timedate iwd git systemd grub-btrfs xorg xdg-user-dirs 
confirm "Was install successful?" 

#Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab
confirm "Ready to chroot?" 

#Prepare the next steps
chmod +x copy.sh
chmod+x part2.sh
timedatectl status
