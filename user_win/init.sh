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
# os_bootloader: 
# os_mounting: automount
# os_ssh:
# os_network:
# os_firewall:
# os_antivirus:
##--------------------------------------------------------------------------------------------------------------------------------------------##
## FUNCTION, ARRAY, HASHTABLE & VARIABLES ##
# package
sys=(                                        
)
wm=(
    
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
sudo apt install ${sys[@]} ${wm[@]} ${app[@]} ${dev[@]}
sudo nala autoremove && sudo nala autoclean
## CONFIGURATION ##
## SERVICES ##










