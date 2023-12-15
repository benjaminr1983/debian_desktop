#!/bin/bash
# ARRAY and VARIABLE
packg=("sway" "swaybg" "foot" "polkit" "wofi" "waybar")

# SCRIPT
paru -S ${packg[@]}
mkdir -p ~/.config/sway & cp /etc/sway/config ~/.config/sway/config
# edit sway config
sed -i 's/dmenu_path | dmenu | xargs swaymsg exec --/wofi --show run/' ~/.config/sway/config



