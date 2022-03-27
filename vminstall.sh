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

confirm "Are you ready to begin?"

chmod +x VM1.sh
./VM1.sh
confirm "Was the drive formatted properly?"

chmod +x VM2.sh
./VM2.sh
confirm "Were the partititons created successfully?"

chmod +x pacstrap.sh
./pacstrap.sh
confirm "Was the base system installed?"

echo "git clone https://github.com/Eliliyah/archinstall
chmod +x /archinstall/arch-chroot.sh
cd archinstall
./vm-arch-chroot.sh" >> /mnt/script.sh
chmod +x /mnt/script.sh
arch-chroot /mnt /script.sh
