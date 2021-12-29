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

#Format the drive
sgdisk --zap-all /dev/sda

sgdisk --clear \
         --new=1:0:+550MiB --typecode=1:ef00 \
         --new=2:0:+1GiB   --typecode=2:8200 \
         --new=3:0:0       --typecode=3:8300 \
           /dev/sda
confirm "Did it zap?"

#Partition the drive and create subvolumes
mkfs.fat -F 32 -n EFI /dev/sda1 
mkswap -L swap -f /dev/sda2 
mkfs.btrfs /dev/sda3 --label=system -f
o=defaults,x-mount.mkdir
o_btrfs=$o,@,defaults,noatime,autodefrag,compress=zstd
mount -t btrfs LABEL=system /mnt 
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/snapshots
umount -R /mnt

#Mount the partitions
mount -t btrfs -o subvol=root,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=snapshots,$o_btrfs LABEL=system /mnt/snapshots
mkdir /mnt/boot
mkfs.fat -F 32 -n EFI /dev/sda1 
mount /dev/sda1 /mnt/boot
swapon -L swap
lsblk
confirm "Partitions look okay?" 

#Install the base system
pacstrap /mnt base linux linux-firmware
pacstrap /mnt dhcpcd linux-zen base-devel btrfs-progs iw gptfdisk zsh terminus-font intel-ucode snapper grub dosfstools man-db man-pages nano usbutils util-linux which neofetch python efibootmgr efitools efivar reflector perl perl-timedate iwd git systemd grub-btrfs xorg xdg-user-dirs 
confirm "Generate fstab, chroot, generate locales and proceed to step 2." 
