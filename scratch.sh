# Name: init.sh 
# Task: install and configure everything needed on you initial Debian setup.
# Purpose: dev/sysadmin purposes | For Standardization we will set it up only with systemd services
# Filesystem: btrfs
# WM: Wayland, sway > ly as login manager
# bootloader: | automatic boot assessment
# network:
# mount:
# firewall:
# ssh:
# antivirus: clamd
# APT::Clean-installed
# ARRAY, HASHTABLES & VARIABLES
# basic system packages
sys=( "exa"  "build-essential" "unzip" "sed" "curl" "wget" "gcc" "make")
way=( "network-manager" "network-manager-gnome" )
apps=("flameshot" "libreoffice" "thunderbird" "flatpak")
# install necessary packages
sudo apt install ${sys[@]} ${way[@]} ${app[@]} ${dev[@]}
flatpak install flathub ${flat[@]}
# check for folder structure
if [ ! -d $HOME/Documents ]; then
    xdg-user-dirs-update
else
    continue 
fi

# install dev environments
# rust
# install 
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#source ~/.cargo/env # activate rust

## edit config files
# zram
# enable ALGO
# replace PERCENT=50 with PERCENT=25
#flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
## SERVICES
# create & edit services

# enable services
#sudo systemctl enable acpid
#sudo systemctl enable avahi-daemon
#sudo systemctl enable ly
#xdg-user-dirs-update

# git repos
#git clone --recurse-submodules https://github.com/fairyglade/ly
#make
#sudo make install installsystemd
# necessary for changes 
#sudo reboot
