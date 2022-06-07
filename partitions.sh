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


#Partition the drive 
mkfs.fat -F 32 -n EFI /dev/nvme0n1
mkswap -L swap -f /dev/nvme0n1p2
mkfs.btrfs /dev/nvme0n1p3 --label=system -f
o=defaults,x-mount.mkdir
o_btrfs=$o,defaults,noatime,autodefrag,compress=lzo
mount -t btrfs LABEL=system /mnt 

#create subvolumes
btrfs subvolume create /mnt/@
mkdir /mnt/boot
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@cache
rm -rf /mnt/log
rm -rf /mnt/tmp
rm -rf /mnt/cache
mkdir /mnt/var/log
mkdir /mnt/var/tmp
mkdir /mnt/var/cache
btrfs quota enable /mnt
umount -R /mnt


#Mount the partitions
mount -t btrfs -o subvol=@,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=@/home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=@/root,$o_btrfs LABEL=system /mnt/root
mount -t btrfs -o subvol=@/srv,$o_btrfs LABEL=system /mnt/srv
mount -t btrfs -o subvol=@/var,$o_btrfs LABEL=system /mnt/var
mount -t btrfs -o subvol=@/log,$o_btrfs LABEL=system /mnt/var/log
mount -t btrfs -o subvol=@/tmp,$o_btrfs LABEL=system /mnt/var/tmp
mount -t btrfs -o subvol=@/cache,$o_btrfs LABEL=system /mnt/var/cache
mount LABEL=EFI /mnt/boot
swapon -L swap
btrfs quota enable /mnt
lsblk
