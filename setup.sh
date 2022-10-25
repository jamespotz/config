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
sudo apt install build-essential curl wget git zsh keychain -y

echo "${green}Installing Archive Utilities...${clear}"
sudo apt install rar unrar p7zip-full p7zip-rar unzip -y
echo "${green}Installing HomeBrew...${clear}"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/jamespotz/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "${green}Installing essential homebrew packages...${clear}"
brew install yadm \
  exa \
  ripgrep \
  neovim \
  fnm \
  zsh \
  antibody \
  bat \
  tree-sitter \
  luajit \
  starship \
  zoxide \
  gcc \
  fd \
  gh \
  lazygit \
  fzf

echo "${green}ZSH setup...${clear}"
[ -f ~/.zshrc ] && mv ~/.zshrc ~/zshrc.bak
wget -O ~/.zsh_plugins.txt https://raw.githubusercontent.com/jamespotz/config/master/zsh_plugins.txt
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
sudo chsh -s "$(which zsh)" "${USER}"

echo "${green}Setup ssh keygen...${clear}"
echo "Email:"
read -r email
ssh-keygen -t ed25519 -C "${email}"
echo "${green}Copy the ssh key below and add to Github/Bitbucket account${clear}"
echo "$(<$HOME/.ssh/id_ed25519.pub)"

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

echo "${green}Installing node v14...${clear}"
fnm install v14
fnm default v14

echo "${green}Installing yarn...${clear}"
fnm exec --using=v14 npm install -g yarn 

echo "${green}Installing neovim packages...${clear}"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "${green}DONE!🚀🚀${clear}"
