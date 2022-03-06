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

#Partition the drive and create subvolumes
mkfs.fat -F 32 -n EFI /dev/sda1
mkswap -L swap -f /dev/sda2
mkfs.btrfs /dev/sda3 --label=system -f
o=defaults,x-mount.mkdir
o_btrfs=$o,defaults,noatime,autodefrag,compress=lzo
mount -t btrfs LABEL=system /mnt 
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@var
umount -R /mnt

#Mount the partitions
mount -t btrfs -o subvol=@,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=@home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=@root,$o_btrfs LABEL=system /mnt/root
mount -t btrfs -o subvol=@srv,$o_btrfs LABEL=system /mnt/srv
mount -t btrfs -o subvol=@cache,$o_btrfs LABEL=system /mnt/cache
mount -t btrfs -o subvol=@log,$o_btrfs LABEL=system /mnt/log
mount -t btrfs -o subvol=@tmp,$o_btrfs LABEL=system /mnt/tmp
mount -t btrfs -o subvol=@var,$o_btrfs LABEL=system /mnt/var
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon -L swap
lsblk
confirm "Partitions look okay?" 
