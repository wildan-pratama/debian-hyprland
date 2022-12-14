#!/bin/sh

# Change Debian to SID Branch
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp sources.list /etc/apt/sources.list 

# Copy Fonts and Background
rm -rf /usr/share/fonts
cp -aR fonts /usr/share


apt update
apt install nala git -y

mkdir Git
cd Git
git clone --recursive https://github.com/hyprwm/Hyprland

git clone https://github.com/Alexays/Waybar

git clone https://github.com/ncopa/xfce-polkit.git
cd ..

# Install sudo and required package
nala upgrade -y
nala install sudo wget curl aria2 zsh apt-transport-https software-properties-common gpg lsb-release ca-certificates -y
nala install btop git build-essential seatd meson ninja-build cmake pkg-config wayland-protocols libgtk-layer-shell-dev -y
nala install xwayland libcairo-dev wlr-randr libwayland-dev libdrm-dev libxkbcommon-dev libudev-dev libseat-dev -y 
nala install libpango1.0-dev libpangocairo-1.0-0 libegl-dev libinput-dev libxcb-xkb-dev libgles-dev wireplumber -y
nala install xdg-desktop-portal-wlr libwlroots-dev libglib2.0-dev libxfce4ui-2-dev libpolkit-agent-1-dev libsndio-dev -y
nala install clang-tidy gobject-introspection libdbusmenu-gtk3-dev libevdev-dev libfmt-dev libgirepository1.0-dev libgtk-3-dev -y
nala install libgtkmm-3.0-dev libinput-dev libjsoncpp-dev libmpdclient-dev libnl-3-dev libnl-genl-3-dev libpulse-dev libjack-dev -y 
nala install libsigc++-2.0-dev libspdlog-dev libwayland-dev scdoc libxkbregistry-dev libupower-glib-dev libgtkmm-3.0-dev -y

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
nala install wlogout swaylock swaybg swayidle grim wl-clipboard rofi xwayland dunst xdg-desktop-portal-wlr qtwayland5 libnm-dev network-manager-gnome sddm slurp -y
nala install nemo libnm-dev network-manager-gnome brave-browser code geany kitty viewnior vlc ranger file-roller nemo-fileroller lxappearance -y
nala install composer network-manager libnss3-tools jq xsel php8.1-cli php8.1-curl php8.1-mbstring php8.1-mcrypt php8.1-xml php8.1-zip php8.1-sqlite3 php8.1-mysql php8.1-pgsql php8.1-fpm -y
nala install mpd mpc ncmpcpp python3-pip pavucontrol wf-recorder -y
# Install Hyprland
cd Git/Hyprland
sudo make install
cd ..

#insall Waybar
cd Waybar
sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
meson --prefix=/usr --buildtype=plain --auto-features=enabled --wrap-mode=default build
meson configure -Dexperimental=true build
sudo ninja -C build install
cd ..

# Install Xfce polkit
cd xfce-polkit
mkdir build
cd build
meson --prefix=/usr ..
ninja
ninja install
cd ..
cd ..

# install Themes and icons
nala install papirus-icon-theme -y
git clone https://github.com/EliverLara/Nordic.git /usr/share/themes/Nordic

# Install Fonts emoji
nala install fonts-noto-color-emoji -y
fc-cache -vf

# Install Liquorix kernel
#echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
#curl 'https://liquorix.net/add-liquorix-repo.sh' | sudo bash


# Purge some package
nala purge foot tilix zutty -y
sudo usermod -aG sudo $USER
nala upgrade -y
sudo mkdir -p /usr/share/desktop-directories/

