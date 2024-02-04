#!/bin/bash
##--------------------------------------------------------------------------------------------------------------------------------------------##
## script_name: init.sh 
## script_version: 0.1
## script_author: Benjamin Reinicke
## start_date: 16.12.2023
## script_license: GPL-2.0
##--------------------------------------------------------------------------------------------------------------------------------------------##
## script_task: create functions
#function userCreation() {
#    
#}
_user=(
    $(awk -F':' '$3>999 {print $1}' /etc/passwd | grep -v nobody)
)

echo ${_user[0]}
