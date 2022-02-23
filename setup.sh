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
sudo apt install rar unrar p7zip-full p7zip-rar -y

echo "${green}Installing HomeBrew...${clear}"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/jamespotz/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "${green}Installing essential homebrew packages...${clear}"
brew install yadm exa ripgrep neovim fnm zsh-syntax-highlighting zsh-autosuggestions bat tree-sitter luajit starship zoxide gcc

echo "${green}ZSH setup...${clear}"
[ -f ~/.zshrc] && mv ~/.zshrc ~/zshrc.bak
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

echo "${green}Installing neovim packages...${clear}"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.neovim
nvim --headless +PackerUpdate +qall

echo "${green}Installing node v14...${clear}"
fnm install v14

echo "${green}Installing global npm packages eslint_d, prettierd, and yarn...${clear}"
npm install -g yarn eslint_d @fsouza/prettierd

echo "${green}DONE!🚀🚀${clear}"
