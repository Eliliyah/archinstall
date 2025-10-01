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
pacman -S grub grub-btrfs efibootmgr efivar efitools --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
sed -i '5,6 s/^/#/' /etc/default/grub
echo "GRUB_DISTRIBUTOR="EllieOS"
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"
GRUB_THEME="/usr/share/grub/themes/EllieOS/theme.txt"">> /etc/default/grub
mv /archinstall/EllieOS /usr/share/grub/themes
grub-mkconfig -o /boot/grub/grub.cfg
confirm "Do you need to run it again?"
nano /etc/default/grub
mv /archinstall/EllieOS /usr/share/grub/themes
grub-mkconfig -o /boot/grub/grub.cfg
