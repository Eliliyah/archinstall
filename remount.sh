#!/usr/bin/bash

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

#create subvolumes
o_btrfs=$o,defaults,noatime,autodefrag,compress=lzo
mount -t btrfs LABEL=system /mnt 
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@var
btrfs quota enable /mnt
umount -R /mnt
btrfs subvolume list /mnt
confirm "All good?"

#Mount the partitions
mount -t btrfs -o subvol=@,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=@home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=@root,$o_btrfs LABEL=system /mnt/root
mount -t btrfs -o subvol=@srv,$o_btrfs LABEL=system /mnt/srv
mount -t btrfs -o subvol=@cache,$o_btrfs LABEL=system /mnt/cache
mount -t btrfs -o subvol=@log,$o_btrfs LABEL=system /mnt/log
mount -t btrfs -o subvol=@tmp,$o_btrfs LABEL=system /mnt/tmp
mount -t btrfs -o subvol=@var,$o_btrfs LABEL=system /mnt/var
mount LABEL=EFI /mnt/boot
swapon -L swap
lsblk
confirm "Mounted?"

#Reinstall the base system
pacstrap /mnt base linux linux-firmware linux-atm linux-headers systemd --noconfirm
pacstrap /mnt nano git linux-zen linux-zen-headers --noconfirm
pacstrap /mnt base-devel --noconfirm 
pacstrap /mnt virtualbox-meta virtualbox-host-dkms --noconfirm 

#Generate fstab
rm /mnt/etc/fstab
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt && mkinitcpio -p linux-zen && grub-mkconfig -o /boot/grub/grub.cfg
umount -R /mnt
