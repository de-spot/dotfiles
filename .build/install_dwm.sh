#!/bin/bash
sudo apt update
sudo apt upgrade
sudo apt install xorg dbus-x11 wget stterm alacritty lf chafa
sudo apt install libx11-dev libxft-dev libxinerama-dev libxrandr-dev
sudo apt install build-essential

sudo apt install fonts-font-awesome
sudo apt install htop
sudo apt install mesa
sudo apt install pulseaudio pavucontrol viewnior cmus scrot ranger fish nitrogen numlockx
sudo apt install alsa-utils alsa-topology-conf
sudo apt install cmus

echo "Found Sound Cards:"
cat /proc/asound/cards
echo -e "\nNow create file /etc/asound.conf with:\ndefaults.pcm.card 1\ndefaults.ctl.card 1"

sudo apt install flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install org.mozilla.firefox

# Install fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
# Install JetBrains Mono font
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)" 
#curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh 
fc-cache -f || (echo "Failed to update font cache"; exit 1)

sudo apt install dmenu
mkdir .build

#file .xinitrc: exec dwm
cd $HOME/.build && git clone git://git.suckless.org/dwm
echo vim config.def.h
cd $HOME/.build/dwm && sudo make clean install
cd $HOME/.build && git clone git://git.suckless.org/slock
cd $HOME/.build/slock && sudo make clean install
<<<<<<< Updated upstream
cd $HOME/.build && git clone git://git.suckless.org/st
cd $HOME/.build/st && sudo make clean install
cd $HOME/.build && git clone git://github.com/davatorium/rofi.git
=======
cd $HOME/.build && git clone git://git.suckless.org/st 
cd $HOME/.build/st && sudo make clean install
>>>>>>> Stashed changes
