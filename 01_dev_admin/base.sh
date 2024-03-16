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
## SETTING
shopt -s nocasematch
shopt -s nocaseglob
## DATA_STRUCTURE
## VARIABLES & ARRAYS
disk=($(lsblk -no PATH -lp | grep -E '/dev/vd|/dev/sd|/dev/nvme')) # This only works when there are no formats
## FUNCTION
## LOGIC
# CREATE TEMP INSTALL DIRECTORY
mkdir .temp_for_setup						    # create setup directory
cd .temp_for_setup						    # go to setup directory
# PARTITIONING
printf "%s\n" "label: gpt" >> tmp.conf.sfdisk
printf "%s\n" "${disk[0]}p1 : size=+512M, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, name= EFI" >> tmp.conf.sfdisk
printf "%s\n" "${disk[0]}p2 : size=+512M, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, name= BOOT" >> tmp.conf.sfdisk
printf "%s\n" "${disk[0]}p3 : size=+100%, type=E6D6D379-F507-44C2-A23C-238F2A3DF928, name= LVM" >> tmp.conf.sfdisk
sfdisk ${disk[0]} < tmp.conf.sfdisk
rm -r tmp.conf.sfdisk
mkfs.fat -F32 "${disk[0]}p1"
mkfs.ext4 "${disk[0]}p2"
cryptsetup --type luks2 --verify-passphrase --sector-size 4096 --verbose luksFormat "${disk[0]}p3"
cryptsetup open --type luks2 "${disk[0]}p3" ssd
pvcreate /dev/mapper/ssd
vgcreate vg0 /dev/mapper/ssd
lvcreate -L 100% vg0 -n deb
modprobe dm-mod
vgchange -ay
mkfs.btrfs /dev/mapper/vg0-deb

# lvm
# create btfs volumes
# home,root,var,snapshot


