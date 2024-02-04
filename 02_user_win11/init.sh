#!/bin/bash
##--------------------------------------------------------------------------------------------------------------------------------------------##
## script_name: init.sh 
## script_version: 0.1
## script_author: Benjamin Reinicke
## start_date: 16.12.2023
## script_license: GPL-2.0
##--------------------------------------------------------------------------------------------------------------------------------------------##
## script_task: install and configure OS
## script_purpose: user/win_10/systemd-only
## os_config
# os_distro: Debian 12 Bookworm/stable Trixie/testing Sid/unstable-rolling
# os_filesystem: btrfs
# os_window manager: wayland/kde
# os_bootloader: systemd-boot 
# os_mounting: systemd.automount
# os_ssh: sshd
# os_network: networkd
# os_firewall: firewalld
# os_antivirus: clamd
##--------------------------------------------------------------------------------------------------------------------------------------------##
## FUNCTION, ARRAY, HASHTABLE & VARIABLES ##
# package
sys=(                                        # system packages that are required so debian 12 works
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
)
wm=(
    "sddm"
    "kde-plasma-desktop"
    "plasma-nm"
    "breeze-kde-theme"
    "kde-config-gtk-style"
    "kde-config-gtk-style-preview"
    "kde-config-sddm"
    "sddm-theme-debian-breeze"
    "plasma-workspace-wayland"
    "kde-config-tablet"
    "kde-config-screenlocker"
    "plymouth-theme-breeze"
    "colord-kde"
    "libreoffice-plasma"
)
app=(
)
flat=(
)
dev=(
)
## PROCEDURES
# package_install
sudo apt update && sudo apt upgrade
sudo apt install ${sys[@]}
sudo nala install ${wm[@]} ${app[@]} ${dev[@]} && sudo nala autoremove
sudo apt autoclean
flatpak install flathub ${flat[@]}
## CONFIGURATION ##
## SERVICES ##










