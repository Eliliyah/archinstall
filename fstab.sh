#!/usr/bin/bash
genfstab -L -p /mnt >> /mnt/etc/fstab
sed -i s+LABEL=swap+/dev/mapper/swap+ /mnt/etc/fstab