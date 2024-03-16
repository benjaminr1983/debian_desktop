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
shopt -s nocasematch                                                                                # no case sensitivity
source ./function.sh
## FUNCTION, ARRAY, HASHTABLE & VARIABLES ##
# package
_sys=(                                                                                               ## SYSTEM PACKAGES
    "sudo"                                                                                           #  elevate permissions
    "vim"                                                                                            #  terminal editor          
    "emacs"                                                                                          #  IDE
    "alacritty"                                                                                      #  terminal
    "curl"                                                                                           #  download protocoll
    "sed"                                                                                            #  streamline editor 
    "unzip"                                                                                          #  compress/decompress files
    "tar"                                                                                            #  compress/decompress files
    "git"                                                                                            #  version control system
    "nala"                                                                                           #  more modern package manager
    "timeshift"                                                                                      #  manages snapshots of the system
    "zram-tools"                                                                                     #  configures virtual swap drive
    "mtools"                                                                                         #  allows access and configuration for ms-dos filesystems
    "dosfstools"                                                                                     #  similar to mtools, those are installed together to allow management of microsoft file systems 
    "acpi"                                                                                           #  tools for power management
    "acpid"                                                                                          #  handler for acpi
    "avahi-daemon"                                                                                   #  network discovery
    "gvfs-backends"                                                                                  #  virtual file system on high level
    "xdg-user-dirs"                                                                                  #  creates user directories
    "firewalld"                                                                                      #  firewall
    "clamav"                                                                                         #  antivirus software
    "clamav-daemon"                                                                                  #  antivirus service
    "libclamunrar9"                                                                                  #  antivirus rar support
    "pipewire-audio"                                                                                 #  sound management
    "wireplumber"                                                                                    #  session manager pipewire
    "pipewire-pulse"                                                                                 #  replacement for pulseaudio
    "pipewire-alsa"                                                                                  #  alsa support
    "libspa-0.2-bluetooth"                                                                           #  bluetooth support
)
_wm=(                                                                                                ## WINDOW MANAGER PACKAGES
    "sddm"                                                                                           #  displaymanager 
    "sway"                                                                                           #  wayland compositor
    "waybar"                                                                                         #  wayland bar for wayland compositors
    "swayidle"                                                                                       #  sway's idle management daemon
    "swaylock"                                                                                       #  screenlocker for wayland
    "swaybg"                                                                                         #  wallpaper utility for wayland
    "wayland-protocols"                                                                              #  adds functionality to wayland
    "xwayland"                                                                                       #  compatibility layer for x11 applications
    "libgtk-layer-shell-dev"                                                                         #  library for gtk applications
    "lxappearance"                                                                                   #  theme-switcher for gtk+
    "policykit-1-gnome"                                                                              #  D-Bus Session bus for authentification
    "mako-notifier"                                                                                  #  wayland notification daemon
    "wofi"                                                                                           #  menu program for wlroots
    "suckless-tools"                                                                                 #  tool-suite for minimalism and functionality
    "xdg-desktop-portal-wlr"                                                                         #  screenshots
    "brightnessctl"                                                                                  #  brightness configuration
    "wl-clipboard"                                                                                   #  clipboard capabilities for wayland
    "dex"                                                                                            #  desktop entry execution
    "jq"                                                                                             #  json manipulation
    "libpam0g-dev"                                                                                   #  pluggable authentication modules libraries
    "libxcb-xkb-dev"                                                                                 #  xkeyboard application
)
_app=(                                                                                               ## REGULAR PACKAGES
    "neofetch"                                                                                       #  displays system information
    "thunar"                                                                                         #  file_manager
    "thunar-archive-plugin"                                                                          #  create and extracts archives using the context menus
    "thunar-volman"                                                                                  #  volume_manager
    "file-roller"                                                                                    #  compression manager for gnome
    "flameshot"                                                                                      #  screenshot tool
    "libreoffice"                                                                                    #  office applications -> office365 replacement
    "thunderbird"                                                                                    #  mail manager -> outlook replacements
    "flatpak"                                                                                        #  package_manager
)
_flat=(                                                                                              ## FLAT PACKAGES
    "com.brave.Browser"                                                                              #  brave browser
    "org.mozilla.firefox"                                                                            #  firefox browser
    "com.spotify.Client"                                                                             #  spotify music library
    "org.kde.okular"                                                                                 #  pdf reader
)
_dev=(                                                                                               ## DEVELOPMENT PACKAGES 
    "build-essential"                                                                                #  allows to create .deb-packages (libc, gcc, g++, make, dpkg-dev) 
    "hoppscotch"                                                                                     #  api_test environment
)
# script
_folder=(                                                                                            ## FOLDER TO BE CREATED
    "Desktop"
    "Downloads"
    "Templates"
    "Public"
    "Documents"
    "Music"
    "Pictures"
    "Videos"
)
_user=(                                                                                              # read out existing users
    $(awk -F':' '$3>999 {print $1}' /etc/passwd | grep -v nobody)                                    
)

_version=(                                                                                           # version array
    "bookworm"
    "trixie"
    "sid"
)
_mirror=(                                                                                            # mirrors to use
    "deb https://deb.debian.org/debian $vers main contrib non-free non-free-firmware"
    "deb https://deb.debian.org/debian $vers-updates main contrib non-free non-free-firmware"
    "deb https://deb.debian.org/debian $vers-proposed-updates main contrib non-free non-free-firmware"
    "deb https://deb.debian.org/debian $vers-security main contrib non-free non-free-firmware"
    "deb https://deb.debian.org/debian $vers-backports main contrib non-free non-free-firmware"
    "deb https://deb.debian.org/debian experimental main contrib non-free non-free-firmware"
)
## PRE-PROCEDURES
# user creation
if [ ${#_user[@]} == 0 ];
then
    # create users / configure users
else
    # create users / configure users     
fi

# configure sudo
for u in "${_user[@]}"
do
    if [  ];
    then
    else
    fi
done
# configure /etc/apt/sources.list

# package_install
apt update && sudo apt upgrade
apt install -t $vers-backports ${_sys[@]}
nala -t $vers-backports install ${_wm[@]} ${_app[@]} ${_dev[@]}
nala autoremove
nala clean
flatpak install flathub ${_flat[@]}

## SYSTEM CONFIGURATION ##
# sudo
# xdg-user-dirs
# ssh
# firewall
## PROCEDURES
# USER ENVIRONMENT
# create user folders
for f in ${_folder[@]};
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
systemctl enable wireplumber.service









