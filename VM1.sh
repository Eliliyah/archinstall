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

confirm "Are you ready to do this?"

#Use timedatectl(1) to ensure the system clock is accurate:
loadkeys us 
timedatectl set-ntp true

#Format the drive
sgdisk --zap-all /dev/nvme0n1

sgdisk --clear \
         --new=1:0:+3GiB --typecode=1:ef00 \
         --new=2:0:+32GiB   --typecode=2:8200 \
         --new=3:0:0       --typecode=3:8300 \
           /dev/nvme0n1
confirm "Did it zap?"

#Partition the drive and create subvolumes
mkfs.fat -F 32 -n EFI /dev/nvme0n1p1 
mkswap -L swap -f /dev/nvme0n1p2 
mkswap -L zram0 /dev/zram0
mkfs.btrfs /dev/nvme0n1p3 --label=system -f
o=defaults,x-mount.mkdir
o_btrfs=$o,defaults,noatime,autodefrag,compress=lz4
mount -t btrfs LABEL=system /mnt 
mkdir /mnt/boot
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@var
umount -R /mnt

#Mount the partitions
mount -t btrfs -o subvol=@,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=@home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=@root,$o_btrfs LABEL=system /mnt/root
mount -t btrfs -o subvol=@srv,$o_btrfs LABEL=system /mnt/srv
mount -t btrfs -o subvol=@cache,$o_btrfs LABEL=system /mnt/cache
mount -t btrfs -o subvol=@log,$o_btrfs LABEL=system /mnt/log
mount -t btrfs -o subvol=@tmp,$o_btrfs LABEL=system /mnt/tmp
mount -t btrfs -o subvol=@var,$o_btrfs LABEL=system /mnt/var
mount /dev/nvme0n1p1 /mnt/boot
swapon --priority 100 /dev/zram0
swapon -L swap
lsblk
confirm "Partitions look okay?" 

#Install the base system
pacstrap /mnt base linux linux-firmware linux-atm linux-headers systemd --noconfirm
pacstrap /mnt accountsservice adobe-source-han-sans-cn-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts alsa-firmware alsa-plugins alsa-utils b43-fwcutter base-devel bash-completion broadcom-wl-dkms btrfs-progs cantarell-fonts crda cryptsetup device-mapper dhclient dialog diffutils dmidecode dmraid dnsmasq dnsutils dosfstools downgrade duf e2fsprogs efibootmgr efitools ethtool exfatprogs f2fs-tools ffmpegthumbnailer findutils freetype2 fsarchiver git glances gnu-netcat grub grub-tools grub-btrfs haveged hdparm hwdetect hwinfo inetutils intel-ucode inxi ipw2100-fw ipw2200-fw iwd jfsutils keyserver-rank less libdvdcss libgsf libopenraw libwnck3 linux-zen linux-zen-headers logrotate lsb-release lsscsi lvm2 man-db man-pages mdadm meld mesa-utils mkinitcpio mkinitcpio-busybox mkinitcpio-nfs-utils mkinitcpio-openswap mlocate modemmanager mtools nano nano-syntax-highlighting nbd ndisc6 neofetch net-tools networkmanager networkmanager-openvpn nfs-utils nilfs-utils nmap noto-fonts nss-mdns ntfs-3g ntp openconnect opendesktop-fonts openvpn os-prober pacman-contrib pcurses perl pkgfile poppler-glib ppp pptpclient pv python python-defusedxml python-packaging rebuild-detector reflector reflector-simple reiserfsprogs rp-pppoe rsync s-nail sed sg3_utils smartmontools sof-firmware sshfs sudo sysfsutils systemd-sysvcompat texinfo tldr power-profiles-daemon ttf-bitstream-vera ttf-dejavu ttf-liberation ttf-opensans unrar unzip upower usb_modeswitch usbutils vpnc welcome wget which whois wireless-regdb wireless_tools wpa_supplicant wvdial xdg-user-dirs xdg-utils xf86-input-libinput chaotic-keyring xf86-video-intel xfsprogs xl2tpd xorg-server xorg-xdpyinfo xorg-xinit xorg-xinput xorg-xkill xorg-xrandr xterm xterm mkinitcpio xz zsh
confirm "Did it work?"

#Generate fstab
genfstab -U -p /mnt >> /mnt/etc/fstab
nano /mnt/etc/fstab
confirm "Did it generate?"
done
