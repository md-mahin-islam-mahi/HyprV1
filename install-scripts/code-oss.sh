#!/bin/bash

CNT="[\e[1;36mNOTE\e[0m]"
CDN="[\e[1;96mDONE\e[0m]"

VS_CODE_SETTINGS=$HOME/.config/Code/User/settings.json
    if [ -f "$VS_CODE_SETTINGS" ]; then
        echo -e "Backing up settings.json for vs-code"
            sudo mv $VS_CODE_SETTINGS $VS_CODE_SETTINGS.backup
    fi
echo -e "$CNT - Copying Vs-Code theme..."
cp -r "$HOME"/HyprV1/extras/settings.json "$HOME"/.config/Code/User/