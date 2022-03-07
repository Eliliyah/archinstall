#!/usr/bin/bash

#FUNCTIONS GO HERE

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "aborted"; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
example-function() {
    echo "Excellent. You haven't broken it. Yet."
}

#Install bootloader
pacman -S grub grub-btrfs efibootmgr efivar efitools
confirm "Did the packages install successfully?"
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
ls /etc/default
confirm "Is the grub file there?"
echo "GRUB_THEME="/usr/share/grub/themes/EllieOS/theme.txt"">> /etc/default/grub
nano /etc/default/grub
mv /archinstall/EllieOS /usr/share/grub/themes
grub-mkconfig -o /boot/grub/grub.cfg
