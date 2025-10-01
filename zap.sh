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

#Use timedatectl(1) to ensure the system clock is accurate:
loadkeys us 
timedatectl set-ntp true
timedatectl set-timezone America/New_York
hwclock --systohc
timedatectl set-ntp true
timedatectl status

#Format the drive
sgdisk --zap-all /dev/nvme0n1

sgdisk --clear \
         --new=1:0:+2048MiB --typecode=1:ef00 \
         --new=2:0:+30720MiB   --typecode=2:8200 \
         --new=3:0:0       --typecode=3:8300 \
           /dev/nvme0n1

