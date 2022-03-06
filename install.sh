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

chmod +x zap.sh
./zap.sh
confirm "Was the drive formatted properly?"

chmod +x partitions.sh
./partitions.sh
confirm "Were the partititons created successfully?"

chmod +x mount.sh
./mount.sh
confirm "Did everything mount properly?"

chmod +x pacstrap.sh
./pacstrap.sh
confirm "Was the base system installed?"

chmod +x user.sh
./user.sh
confirm "Were the locales set and user created successfully?"

chmod +x keyrings.sh
./keyrings.sh
confirm "Did the keyrings install and mirrors update successfully?"

chmod +x pacman.sh
./pacman.sh
confirm "Did all packages install successfully?"

chmod +x config.sh
./config.sh
confirm "Was the system configured successfully?"

chmod +x grub.sh
./grub.sh
confirm "Was the bootloader installed properly?"





