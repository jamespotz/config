#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

# Set up the shell variables for colors
# http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
yellow=$(tput setaf 3);
green=$(tput setaf 2);
clear=$(tput sgr0);

echo "${green}Update/Upgrade system...${clear}"
sudo apt update && sudo apt dist-upgrade -y

echo "${green}Installing Build Essential and more...${clear}"
sudo apt install build-essential curl wget git zsh -y

echo "${green}Installing Archive Utilities...${clear}"
sudo apt install rar unrar p7zip-full p7zip-rar unzip -y

echo "${green}Installing nix...${clear}"
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh

echo "${green}Installing essential nix packages...${clear}"
nix-env -iA \
  nixpkgs.zsh \
  nixpkgs.exa \
  nixpkgs.antibody \
  nixpkgs.ripgrep \
  nixpkgs.neofetch \
  nixpkgs.resholved-yadm \
  nixpkgs.starship \
  nixpkgs.stylua \
  nixpkgs.tree-sitter \
  nixpkgs.fd \
  nixpkgs.fnm \
  nixpkgs.gh \
  nixpkgs.bat \
  nixpkgs.zoxide \
  nixpkgs.lazygit \
  nixpkgs.fzf

echo "${green}ZSH setup...${clear}"
[ -f ~/.zshrc] && mv ~/.zshrc ~/zshrc.bak
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
sudo chsh -s "$(which zsh)" "${USER}"

echo "${green}Setup ssh keygen...${clear}"
echo "Email:"
read -r email
ssh-keygen -t rsa -b 4096 -C "${email}"
echo "${green}Copy the ssh key below and add to Github/Bitbucket account${clear}"
echo "$(<$HOME/.ssh/id_rsa.pub)"

echo "${green}Press [SPACE] to continue...${clear}"
read -r -s -d ' '

echo "${green}Creating work directory...${clear}"
mkdir -p "${HOME}/Work"

echo "${green}Cloning config...${clear}"
yadm clone git@github.com:jamespotz/config.git

echo "${green}Installing win32yank...${clear}"
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/

echo "${green}Installing neovim...${clear}"
cd /tmp && wget https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb

echo "${green}Installing neovim packages...${clear}"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.neovim
nvim --headless +PackerUpdate +qall

echo "${green}Installing node v14...${clear}"
fnm install v14
fnm default v14

echo "${green}Installing global npm packages eslint_d, prettierd, and yarn...${clear}"
fnm exec --using=v14 npm install -g yarn eslint_d @fsouza/prettierd

echo "${green}DONE!🚀🚀${clear}"
