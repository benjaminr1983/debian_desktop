## packages
# array
# basic system packages
sys=("vim" "emacs" "git" "timeshift" "nala" "zram-tools" "exa" "neofetch" "alacritty" "mtools" "dosfstools" "acpi" "acpid" "avahi-daemon" "gvfs-backends" "thunar" "thunar-archive-plugin" "thunar-volman" "file-roller" "build-essential" "unzip" "sed" "curl" "wget" "gcc" "make")
way=("sway" "waybar" "swayidle" "swaylock" "swaybg" "wayland-protocols" "xwayland" "libgtk-layer-shell-dev" "lxappearance" "policykit-1-gnome" "network-manager" "network-manager-gnome" "mako-notifier" "wofi" "suckless-tools" "xdg-desktop-portal-wlr" "brightnessctl" "wl-clipboard" "dex" "jq" "libpam0g-dev" "libxcb-xkb-dev")
apps=("flameshot" "libreoffice" "thunderbird" "flatpak")
flat=("com.brave.Browser" "org.mozilla.firefox")
dev=("")
# install necessary packages
sudo apt install ${sys[@]} ${way[@]} ${app[@]} ${dev[@]}
flatpak install flathub ${flat[@]}
# install dev environments
# rust
# install 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env # activate rust

## edit config files
# zram
# enable ALGO
# replace PERCENT=50 with PERCENT=25
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
#enable services
sudo systemctl enable acpid
sudo systemctl enable avahi-daemon
sudo systemctl enable ly
xdg-user-dirs-update

# git repos
git clone --recurse-submodules https://github.com/fairyglade/ly
make
sudo make install installsystemd
# necessary for changes 
sudo reboot