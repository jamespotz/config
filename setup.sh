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
  fnm \
  zsh \
  bat \
  tree-sitter \
  luajit \
  starship \
  zoxide \
  gcc \
  fd \
  gh \
  lazygit \
  fzf \
  git-delta \
  selene \
  luarocks \
  mcfly

echo "${green}ZSH setup...${clear}"
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
chmod u+x ~/.antidote/antidote
[ -f ~/.zshrc ] && mv ~/.zshrc ~/zshrc.bak
wget -O ~/zsh_plugins.txt https://github.com/jamespotz/config/raw/master/.zsh_plugins.txt
~/.antidote/antidote bundle < ~/zsh_plugins.txt > ~/.zsh_plugins.zsh
sudo chsh -s "$(which zsh)" "${USER}"

echo "${green}Setup ssh keygen...${clear}"
echo "Email:"
read -r email
ssh-keygen -t ed25519 -C "${email}"
echo "${green}Copy the ssh key below and add to Github/Bitbucket account${clear}"
echo "$(<$HOME/.ssh/id_ed25519.pub)"

echo "${green}Installing bob, rustup and neovim...${clear}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
cargo install --git https://github.com/MordechaiHadad/bob.git
bob install stable
bob use stable

echo "${green}Press [SPACE] to continue...${clear}"
read -r -s -d ' '

echo "${green}Creating work directory...${clear}"
mkdir -p "${HOME}/Work"

echo "${green}Cloning config...${clear}"
yadm clone git@github.com:jamespotz/config.git

echo "${green}Installing neovim packages...${clear}"
nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonInstall eslint_d prettier luacheck stylua markdownlint" +qa

echo "${green}DONE!🚀🚀${clear}"
