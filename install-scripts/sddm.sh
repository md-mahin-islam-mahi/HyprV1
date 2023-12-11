#!/bin/bash

# colors
CNT="[\e[1;36mNOTE\e[0m]"
CDN="[\e[1;96mDONE\e[0m]"


# Set the script to exit on error
set -e

SDDM_THEME=$HOME/HyprV1/extras/sddm-theme
    echo -e "$CNT - Setting up the login screen."
    sudo cp -R $SDDM_THEME /usr/share/sddm/themes/
    sudo chown -R $USER:$USER /usr/share/sddm/themes/sddm-theme
    sudo mkdir /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sddm-theme" | sudo tee -a /etc/sddm.conf.d/10-theme.conf
    echo -e "$CDN - Sddm theme installed."

    sleep 1