#!/bin/bash

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"

#clear the screen
clear

ISAUR=$(command -v yay || command -v paru)

# Set the script to exit on error
set -e

# Function for installing packages
install_package() {
  # Checking if package is already installed
  if $ISAUR -Q "$1" &>> /dev/null ; then
    echo -e "${OK} $1 is already installed. Skipping..."
  else
    # Package not installed
    echo -e "${NOTE} Installing $1 ..."
    $ISAUR -S --noconfirm "$1" 2>&1
    # Making sure package is installed
    if $ISAUR -Q "$1" &>> /dev/null ; then
      echo -e "\e[1A\e[K${OK} $1 was installed."
    else
      # Something is missing, exiting to review log
      echo -e "\e[1A\e[K${ERROR} $1 failed to install :("
      exit 1
    fi
  fi
}
# zsh and oh-my-zsh

echo
  for ZSH in zsh zsh-completions; do
    install_package "$ZSH" 2>&1
    if [ $? -ne 0 ]; then
      echo -e "\e[1A\e[K${ERROR} - $ZSH install had failed."
    fi
  done

  # Oh-my-zsh plus zsh-autosuggestions and zsh-syntax-highlighting
  echo -e "$CNT - installing zsh, oh-my-zsh and powerlevel10k theme"
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \

  if [ -f ~/.zshrc ]; then
  echo -e "$CNT - Backing up the .zshrc to .zshrc.back\n"
    mv ~/.zshrc ~/.zshrc.back
    sleep 1

    echo -e "$CDN - Backup done"
  fi

  if [ -f ~/.p10k.zsh ]; then
  echo -e "$CNT - Backing up the .p10k.zsh file to .p10k.zsh.back"
    mv ~/.p10k.zsh ~/.p10k.zsh.back
  fi

  sleep 1

    echo -e "$CAC - Copying .zshrc and .p10k.zsh"
    cp -r $HOME/HyprV1/extras/.zshrc ~/
    cp -r $HOME/HyprV1/extras/.p10k.zsh ~/
    echo -e "$CDN - copying finished, making zsh default"
    sudo chsh -s /usr/bin/zsh 