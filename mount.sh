#!/usr/bin/bash
mount -t btrfs -o subvol=@,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=@home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=@root,$o_btrfs LABEL=system /mnt/root
mount -t btrfs -o subvol=@srv,$o_btrfs LABEL=system /mnt/srv
mount -t btrfs -o subvol=@cache,$o_btrfs LABEL=system /mnt/cache
mount -t btrfs -o subvol=@log,$o_btrfs LABEL=system /mnt/log
mount -t btrfs -o subvol=@tmp,$o_btrfs LABEL=system /mnt/tmp
mount -t btrfs -o subvol=@var,$o_btrfs LABEL=system /mnt/var
mount /dev/nvme0n1p1 /mnt/boot
swapon -L swap
lsblk
arch-chroot /mnt
