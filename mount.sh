#!/usr/bin/bash
mount -t btrfs -o subvol=root,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=snapshots,$o_btrfs LABEL=system /mnt/snapshots
mount /dev/sda1 /mnt/boot
swapon -L swap
lsblk
