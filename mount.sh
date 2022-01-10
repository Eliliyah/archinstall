#!/usr/bin/bash
mount -t btrfs -o subvol=@,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=@home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=@var,$o_btrfs LABEL=system /mnt/var
mount -t btrfs -o subvol=@.snapshots,$o_btrfs LABEL=system /mnt/.snapshots
mount /dev/nvme0n1p1 /mnt/boot
swapon -L swap
lsblk
