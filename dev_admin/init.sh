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
# os_filesystem:
# os_window manager:
# os_bootloader:
# os_mounting:
# os_ssh:
# os_network:
# os_firewall:
# os_antivirus:
##--------------------------------------------------------------------------------------------------------------------------------------------##
## FUNCTION, ARRAY, HASHTABLE & VARIABLES ##
# package
sys=(                                        # system packages that are required so debian 12 works
    "vim"                                    # terminal editor          
    "emacs"                                  # IDE
    "alacritty"                              # terminal
    "wget"
    "curl"
    "sed"
    "unzip"
    "tar"
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
    
)
app=(
    "neofetch"
    "thunar"
    "thunar-archive-plugin"
    "file-roller"
)
flat=(
    "com.brave.Browser"
    "org.mozilla.firefox"
    "com.spotify.Client"
)
dev=(
    "build-essential"
    "make"
)
## PROCEDURES
# package_install
sudo apt update && sudo apt upgrade
sudo apt install ${sys[@]} ${wm[@]} ${app[@]} ${dev[@]}
sudo nala autoremove && sudo nala autoclean
## CONFIGURATION ##
## SERVICES ##










