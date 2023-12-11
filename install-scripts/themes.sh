#!/bin/bash

# colors
CDN="[\e[1;96mDONE\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"

# Install THEME

THEME_LIGHT=$HOME/HyprV1/extras/themes/theme-light
THEME_DARK=$HOME/HyprV1/extras/themes/theme
KVANTUM=$HOME/HyprV1/extras/Kvantum
CONFIG_DIR=$HOME/.config
ICON=$HOME/HyprV1/extras/Icon_TelaDracula.tar.gz
CURSOR=$HOME/HyprV1/extras/Nordzy-cursors.tar.gz
GTK=$HOME/HyprV1/extras/gtk-3.0
QT5CT=$HOME/HyprV1/extras/qt5ct

for THEME in $THEME_DARK $THEME_LIGHT; do
    THEME_DIR=~/.themes
    if [ -d "$THEME_DIR" ]; then
        echo -e "$CAC - Copying $THEME to the $THEME_DIR directory.."
        cp -r $THEME $THEME_DIR/

    else
        echo -e "$CAT - .themes directory does not exist. Creating directory.."
        mkdir ~/.themes

        sleep 1

        echo -e "$CAC - Copying $THEME to the .themes directory.."
        cp -r $THEME $THEME_DIR/
        echo -3 "$CDN - Copying gtk light and dark theme done.."
    fi

done

QT5CT_DIR=~/.config/qt5ct
if [ -d $QT5CT_DIR ]; then
    echo -e "$CAC - Backing up qt5ct Configs..."
    mv $QT5CT_DIR "$QT5CT_DIR-back"
fi
sleep 1
cp -r $QT5CT ~/.config/
echo -e "$CDN - Copying qt5ct themes done..."

KVANTUM_DIR=~/.config/Kvantum
if [ -d $KVANTUM_DIR ]; then
    echo -e "$CAC - Backing up Kvantum Configs..."
    mv $KVANTUM_DIR "$KVANTUM_DIR-back"
fi
sleep 1
cp -r $KVANTUM ~/.config/
echo -e "$CDN - Copying Kvantum themes done..."

mkdir -p ~/.icons
cp -r $ICON ~/.icons
cp -r $CURSOR ~/.icons

GTK_DIR=~/.config/gtk-3.0
if [ -d $GTK_DIR ]; then
    mv $GTK_DIR "$GTK_DIR-back"
    cp -r $GTK ~/.config/
fi

file_dir=/etc/environment
sudo sh -c "echo \"QT_QPA_PLATFORMTHEME='qt5ct'\" >> $file_dir"

cd ~/.icons
tar xf Nordzy-cursors.tar.gz
tar xf Icon_TelaDracula.tar.gz

read -n1 -rep "$CDN - installation completed, would you like to rebooting your system...[ y/n ]" REBOOT

if [[ $REBOOT == "Y" || $REBOOT == "y" ]]; then
    echo -e "$CNT - Syste will reboot now.."
    sleep 1
    reboot
else
    exit 1
fi

# echo -e "${COK} - THEME added sucessfully! Now you can toggle between light and dark mode."
