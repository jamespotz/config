#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

# Set up the shell variables for colors
yellow=$(tput setaf 3);
green=$(tput setaf 2);
clear=$(tput sgr0);

echo "${green}Update/Upgrade system...${clear}"
sudo pacman -Syu --noconfirm

echo "${green}Installing Build Essential and more...${clear}"
sudo pacman -S --needed --noconfirm base-devel curl wget git zsh keychain yadm ripgrep glances ca-certificates

echo "${green}Installing Archive Utilities...${clear}"
sudo pacman -S --needed --noconfirm unrar p7zip unzip

echo "${green}Installing rustup, lsd and bob...${clear}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install --git https://github.com/lsd-rs/lsd.git --branch master
cargo install --git https://github.com/MordechaiHadad/bob.git
bob install stable
bob use stable

echo "${green}Installing zoxide...${clear}"
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo "${green}Installing mcfly...${clear}"
curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly

echo "${green}Installing fnm...${clear}"
curl -fsSL https://fnm.vercel.app/install | bash

echo "${green}Installing lazydocker...${clear}"
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

echo "${green}Installing starship...${clear}"
curl -sS https://starship.rs/install.sh | sh

echo "${green}Installing docker...${clear}"
sudo pacman -Rns --noconfirm docker docker-compose podman-docker containerd runc
sudo pacman -S --needed --noconfirm docker docker-compose

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

echo "${green}Press [SPACE] to continue...${clear}"
read -r -s -d ' '

echo "${green}Creating work directory...${clear}"
mkdir -p "${HOME}/Work"

echo "${green}Cloning config...${clear}"
yadm clone git@github.com:jamespotz/config.git

if command -v nvim &> /dev/null; then
    echo "${green}Neovim is already installed.${clear}"
    echo "${green}Installing neovim packages...${clear}"
    nvim --headless "+Lazy! sync" +qa
    nvim --headless "+MasonInstall eslint_d prettier luacheck stylua markdownlint" +qa
fi

echo "${green}DONE!🚀🚀${clear}"
