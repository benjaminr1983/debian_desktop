#!/bin/bash
##--------------------------------------------------------------------------------------------------------------------------------------------##
## script_name: init.sh 
## script_version: 0.1
## script_author: Benjamin Reinicke
## start_date: 16.12.2023
## script_license: GPL-2.0
##--------------------------------------------------------------------------------------------------------------------------------------------##
## script_task: install and configure OS
## script_purpose: dev/sysadmin/systemd-only
## os_config
# os_distro: Debian 12 Bookworm/stable Trixie/testing Sid/unstable-rolling
# os_filesystem: btrfs
# os_window manager: wayland/sway
# os_bootloader: systemd-boot
# os_mounting: systemd.automount
# os_ssh: sshd
# os_network: networkd
# os_firewall: firewalld
# os_antivirus: clamd
##--------------------------------------------------------------------------------------------------------------------------------------------##
## SCRIPT SETTING
shopt -s nocasematch                         # no case sensitivity
source ./function.sh
## FUNCTION, ARRAY, HASHTABLE & VARIABLES ##
# package
sys=(                                        # system packages that are required so debian 12 works
    "sudo"                                   # elevate permissions
    "vim"                                    # terminal editor          
    "emacs"                                  # IDE
    "alacritty"                              # terminal
    "curl"                                   # download protocoll
    "sed"                                    # streamline editor 
    "unzip"                                  # compress/decompress files
    "tar"                                    # compress/decompress files
    "git"                                    # version control system
    "nala"                                   # more modern package manager
    "timeshift"                              # manages snapshots of the system
    "zram-tools"                             # configures virtual swap drive
    "mtools"                                 # allows access and configuration for ms-dos filesystems
    "dosfstools"                             # similar to mtools, those are installed together to allow management of microsoft file systems 
    "acpi"                                   # tools for power management
    "acpid"                                  # handler for acpi
    "avahi-daemon"                           # network discovery
    "gvfs-backends"                          # virtual file system on high level
    "xdg-user-dirs"                          # creates user directories
)
wm=(                                         # packages required for the wm
    "sddm"                                   # displaymanager 
    "sway"                                   # wayland compositor
    "waybar"                                 # wayland bar for wayland compositors
    "swayidle"                               # sway's idle management daemon
    "swaylock"                               # screenlocker for wayland
    "swaybg"                                 # wallpaper utility for wayland
    "wayland-protocols"                      # adds functionality to wayland
    "xwayland"                               # compatibility layer for x11 applications
    "libgtk-layer-shell-dev"                 # library for gtk applications
    "lxappearance"                           # theme-switcher for gtk+
    "policykit-1-gnome"                      # D-Bus Session bus for authentification
    "mako-notifier"                          # wayland notification daemon
    "wofi"                                   # menu program for wlroots
    "suckless-tools"                         # tool-suite for minimalism and functionality
    "xdg-desktop-portal-wlr"                 # screenshots
    "brightnessctl"                          # brightness configuration
    "wl-clipboard"                           # clipboard capabilities for wayland
    "dex"                                    # desktop entry execution
    "jq"                                     # json manipulation
    "libpam0g-dev"                           #
    "libxcb-xkb-dev"                         #
)
app=(
    "neofetch"                               #
    "thunar"                                 #
    "thunar-archive-plugin"                  #
    "thunar-volman"                          #
    "file-roller"                            #
    "flameshot"                              #
    "libreoffice"                            # 
    "thunderbird"                            #
    "flatpak"                                #
)
flat=(
    "com.brave.Browser"                      #
    "org.mozilla.firefox"                    #
    "com.spotify.Client"                     #
    "org.kde.okular"                         #
)
dev=(
    "build-essential"                        #
    "gcc"                                    #
    "make"                                   #
    "hoppscotch"                             #
)
# script
folder=(
    "Desktop"
    "Downloads"
    "Templates"
    "Public"
    "Documents"
    "Music"
    "Pictures"
    "Videos"
)
user=(
    awk -F':' '{print $1}' /etc/passwd
)
## PRE-PROCEDURES
# package_install
sudo apt update && sudo apt upgrade
sudo apt install ${sys[@]}
sudo nala install ${wm[@]} ${app[@]} ${dev[@]} && sudo nala autoremove
sudo apt autoclean
flatpak install flathub ${flat[@]}
# user creation

## SYSTEM CONFIGURATION ##
# sudo
# xdg-user-dirs
# ssh
# firewall
## PROCEDURES
# USER ENVIRONMENT
# create user folders
for f in ${folder[@]};
do
    if [ ! -d $HOME/$f ];
    then
	xdg-user-dirs-update
    else
	continue
    fi
done
# DEVELOPMENT ENVIRONMENT
# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rust.rs | sh
## ENVIRONMENT CONFIGURATION
# adapt .bashrc
printf '\n%s\n' '## DEVELOPMENT PATHS'

# rust
if [ ! -d $HOME/.cargo/env ]; then
   mkdir -p $HOME/.cargo/env
   printf '\n%s\n' '# rust'
   printf '\n%s\n' 'source $HOME/.cargo/env'
else
   printf '\n%s\n' '# rust'
   printf '\n%s\n' 'source $HOME/.cargo/env'
fi

## SERVICES ##










