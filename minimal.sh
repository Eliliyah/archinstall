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

#Install important packages
pacman -Sy --needed aura accountsservice acpid adobe-source-han-sans-cn-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts alsa-firmware alsa-plugins alsa-utils b43-fwcutter bash-completion broadcom-wl-dkms btrfs-progs cantarell-fonts crda cryptsetup device-mapper dhclient dialog diffutils dmidecode dmraid dnsmasq dnsutils dosfstools downgrade duf --noconfirm
pacman -S e2fsprogs ethtool exfatprogs f2fs-tools ffmpegthumbnailer findutils freetype2 fsarchiver fuse glances gnu-netcat haveged hdparm hwdetect hwinfo inetutils intel-ucode inxi ipw2100-fw ipw2200-fw iwd jfsutils keyserver-rank less libdvdcss libgsf libopenraw libwnck3 lm_sensors logrotate lsb-release lsscsi lvm2 man-db man-pages mdadm meld mesa-utils --noconfirm
pacman -S mkinitcpio mkinitcpio-busybox mkinitcpio-nfs-utils mkinitcpio-openswap mlocate modemmanager mtools nano-syntax-highlighting nbd ndisc6 neofetch net-tools networkmanager networkmanager-openvpn nfs-utils nilfs-utils nmap noto-fonts nss-mdns ntfs-3g ntp openconnect opendesktop-fonts openvpn os-prober pacman-contrib pcurses perl pkgfile --noconfirm
pacman -S poppler-glib ppp pptpclient pv python python-defusedxml python-packaging rebuild-detector reflector reflector-simple reiserfsprogs rp-pppoe rsync s-nail sed sg3_utils smartmontools sshfs sudo sysfsutils systemd-sysvcompat texinfo tldr power-profiles-daemon ttf-bitstream-vera ttf-dejavu ttf-liberation ttf-opensans unrar 
pacman -S unzip upower usb_modeswitch usbutils vpnc wget which whois wireless-regdb wireless_tools wpa_supplicant wvdial xdg-user-dirs xdg-utils xf86-input-libinput xf86-video-intel xfsprogs xl2tpd xorg-server xorg-xdpyinfo xorg-xinit xorg-xinput xorg-xkill xorg-xrandr xterm xterm xz zsh --noconfirm

#Install build tools
pacman -S --needed go go-tools meson cmake extra-cmake-modules rust flatpak yajl docker --noconfirm

#Install plasma 
pacman -S --needed ark breeze-gtk dolphin gwenview kdeconnect qt5-base pass kde-gtk-config ksystemlog khotkeys kinfocenter kinit kio-fuse konsole kscreen kwallet-pam okular plasma-desktop plasma-disks plasma-nm plasma-pa powerdevil sddm-kcm solid spectacle xsettingsd power-profiles-daemon --noconfirm

#Instal optional applications
pacman -S --needed dolphin-plugins preload ffmpegthumbs kamoso kcalc kdegraphics-thumbnailers kdesdk-thumbnailers kfind kmix ksystemlog ktorrent aspell-en libappimage pacmanlogviewer oxygen latte-dock kvantum-theme-sweet-git ksystemstats intel-gpu-tools intel-media-driver haskell-emojis garuda-starship-prompt --noconfirm

pacman -S --needed fish fish-autopair gimp discord file-roller vivaldi vivaldi-ffmpeg-codecs code pam-u2f starship --noconfirm

#Install audio applications
pacman -S --needed pipewire sof-firmware --noconfirm
pacman -S --needed pipewire-alsa pipewire-media-session pipewire-pulse pipewire-v4l2 pipewire-zeroconf gst-plugin-pipewire alsa-card-profiles lv2 openal opus bluez bluedevil --noconfirm
