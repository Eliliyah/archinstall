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
timedatectl set-ntp true

#Format the drive
sgdisk --zap-all /dev/sda

sgdisk --clear \
         --new=1:0:+3GiB --typecode=1:ef00 \
         --new=2:0:+32GiB   --typecode=2:8200 \
         --new=3:0:0       --typecode=3:8300 \
           /dev/sda
confirm "Did it zap?"

#Partition the drive and create subvolumes
mkfs.fat -F 32 -n EFI /dev/sda1 
mkswap -L swap -f /dev/sda2 
mkfs.ext4 /dev/sda3 --label=system -f

#Mount the partitions
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon -L swap
lsblk
confirm "Partitions look okay?" 

#Install the base system
pacstrap /mnt base linux linux-firmware linux-atm linux-headers systemd --noconfirm
pacstrap /mnt nano git linux-zen linux-zen-headers reflector --noconfirm
pacstrap /mnt base-devel
confirm "Did it work?"

#Generate fstab
genfstab -U -p /mnt >> /mnt/etc/fstab
nano /mnt/etc/fstab
confirm "Did it generate?"
