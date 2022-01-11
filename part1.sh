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
sgdisk --zap-all /dev/nvme0n1

sgdisk --clear \
         --new=1:0:+3GiB --typecode=1:ef00 \
         --new=2:0:+32GiB   --typecode=2:8200 \
         --new=3:0:0       --typecode=3:8300 \
           /dev/nvme0n1
confirm "Did it zap?"

#Partition the drive and create subvolumes
mkfs.fat -F 32 -n EFI /dev/nvme0n1p1 
mkswap -L swap -f /dev/nvme0n1p2 
mkfs.btrfs /dev/nvme0n1p3 --label=system -f
o=defaults,x-mount.mkdir
o_btrfs=$o,defaults,noatime,autodefrag,compress=zstd
mount -t btrfs LABEL=system /mnt 
mkdir /mnt/boot
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
umount -R /mnt

#Mount the partitions
mount -t btrfs -o subvol=@,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=@home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=@root,$o_btrfs LABEL=system /mnt/root
mount -t btrfs -o subvol=@srv,$o_btrfs LABEL=system /mnt/srv
mount -t btrfs -o subvol=@cache,$o_btrfs LABEL=system /mnt/cache
mount -t btrfs -o subvol=@log,$o_btrfs LABEL=system /mnt/log
mount -t btrfs -o subvol=@tmp,$o_btrfs LABEL=system /mnt/tmp
mount /dev/nvme0n1p1 /mnt/boot
swapon -L swap
lsblk
confirm "Partitions look okay?" 

#Install the base system
pacstrap /mnt base linux linux-firmware
pacstrap /mnt btrfs-progs
pacstrap /mnt dhcpcd linux-zen linux-zen-headers base-devel iw gptfdisk zsh terminus-font intel-ucode snapper grub dosfstools man-db man-pages nano usbutils util-linux which neofetch python efibootmgr efitools efivar reflector perl perl-timedate iwd git systemd grub-btrfs xorg xdg-user-dirs 
confirm "Did it work?"

#Generate fstab
genfstab -L -p /mnt >> /mnt/etc/fstab
nano /mnt/etc/fstab
confirm "Did it generate?"
arch-chroot /mnt
