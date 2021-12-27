cryptsetup open --type plain --key-file /dev/urandom /dev/sda2 swap
mkswap -L swap /dev/mapper/swap
swapon -L swap

mount -t btrfs -o subvol=root,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=snapshots,$o_btrfs LABEL=system /mnt/.snapshots
mkdir /mnt/boot
mount LABEL=EFI /mnt/boot