sudo pacman -Syu 
sudo pacman -S flatpak libappimage wget yajl

cd /tmp
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg -si
sudo pacman -Syu

sudo aura -A paperde
