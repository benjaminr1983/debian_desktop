#!/bin/bash
##--------------------------------------------------------------------------------------------------------------------------------------------##
## script_name: base.sh 
## script_version: 0.1
## script_author: Benjamin Reinicke
## start_date: 25.12.2023
## script_license: GPL-2.0
##--------------------------------------------------------------------------------------------------------------------------------------------##
## script_task: install Debian 12 Base
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
shopt -s nocasematch
shopt -s nocaseglob
## VARIABLES & ARRAYS
disk=$(lsblk -no PATH -lp | grep -E '/dev/vd|/dev/sd|/dev/nvme') # This only works when there are no formats
## DISK CONFIGURATION
# partitioning
sfdisk $disk < conf.sfdisk # configure disk
# encryption
fdisk=(
    $(lsblk -no PATH -lp | grep -E '/dev/vd|/dev/sd|/dev/nvme')
)
cryptsetup --type luks2 --verify-passphrase --sector-size 4096 --verbose luksFormat ${fdisk[2]}


