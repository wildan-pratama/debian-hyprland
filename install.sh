#!/bin/sh

# Change Debian to SID Branch
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp sources.list /etc/apt/sources.list 

# Copy Fonts and Background
rm -rf /usr/share/fonts
cp -aR fonts /usr/share

# Install sudo and required package
apt update
apt install nala -y
nala upgrade -y
nala install sudo wget curl zsh apt-transport-https software-properties-common gpg lsb-release ca-certificates -y
nala install btop git build-essential seatd meson ninja-build cmake pkg-config wayland-protocols -y
nala install xwayland libcairo-dev wlr-randr libwayland-dev libdrm-dev libxkbcommon-dev libudev-dev libseat-dev -y 
nala install libpango1.0-dev libpangocairo-1.0-0 libegl-dev libinput-dev libxcb-xkb-dev libgles-dev -y
nala install xdg-desktop-portal-wlr libwlroots-dev libglib2.0-dev libxfce4ui-2-dev libpolkit-agent-1-dev -y

# Install Hyprland
mkdir Git
cd Git
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
sudo make install

# Install Xfce polkit
cd ..
git clone https://github.com/ncopa/xfce-polkit.git
cd xfce-polkit
mkdir build
cd build
meson --prefix=/usr ..
ninja
ninja install
cd ..
cd ..
rm -rf Git

# Add aditional repo
# Add Brave repo
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Add PHP Surya repo
echo "deb https://packages.sury.org/php/ bullseye main" | sudo tee /etc/apt/sources.list.d/sury-php.list
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -

# Add Visual Studio Code repo
cp -aR vscode.list /etc/apt/sources.list.d/
cp -aR microsoft.gpg /etc/apt/trusted.gpg.d/

#install aditional pacakge
nala upgrade -y
nala install waybar swaylock swaybg swayidle grim wl-clipboard rofi xwayland dunst xdg-desktop-portal-wlr qtwayland5 libnm-dev network-manager-gnome sddm slurp -y
nala install nemo libnm-dev network-manager-gnome brave-browser code geany kitty viewnior vlc ranger file-roller nemo-fileroller lxappearance mpd mpc ncmpcpp python3-pip pavucontrol -y
nala install composer network-manager libnss3-tools jq xsel php8.1-cli php8.1-curl php8.1-mbstring php8.1-mcrypt php8.1-xml php8.1-zip php8.1-sqlite3 php8.1-mysql php8.1-pgsql php8.1-fpm -y

# install Themes and icons
nala install papirus-icon-theme -y
git clone https://github.com/EliverLara/Nordic.git /usr/share/themes/Nordic

# Install Fonts emoji
nala install fonts-noto-color-emoji -y
fc-cache -vf

# Install Liquorix kernel
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
curl 'https://liquorix.net/add-liquorix-repo.sh' | sudo bash

sudo usermod -aG sudo $USER
nala upgrade -y

