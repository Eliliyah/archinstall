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

#Mount the partitions
mount -t btrfs -o subvol=@,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=@/home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=@/root,$o_btrfs LABEL=system /mnt/root
mount -t btrfs -o subvol=@/srv,$o_btrfs LABEL=system /mnt/srv
mount -t btrfs -o subvol=@/cache,$o_btrfs LABEL=system /mnt/cache
mount -t btrfs -o subvol=@/log,$o_btrfs LABEL=system /mnt/log
mount -t btrfs -o subvol=@/tmp,$o_btrfs LABEL=system /mnt/tmp
mount -t btrfs -o subvol=@/var,$o_btrfs LABEL=system /mnt/var
mount LABEL=EFI /mnt/boot
swapon -L swap
lsblk

confirm "Partitions look okay?"

rm /etc/fstab
genfstab -p -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt && mkinitcpio -p linux-zen && grub-mkconfig -o /boot/grub/grub.cfg && nano /etc/fstab
confirm "All good?"
umount -R /mnt
reboot
