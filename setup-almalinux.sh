#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

# Set up the shell variables for colors
yellow=$(tput setaf 3);
green=$(tput setaf 2);
clear=$(tput sgr0);

echo "${green}Update/Upgrade system...${clear}"
sudo dnf update -y

echo "${green}Installing Development Tools and more...${clear}"
sudo dnf groupinstall "Development Tools" -y
sudo dnf install curl wget git zsh keychain ca-certificates yum-utils -y
sudo curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && sudo chmod a+x /usr/local/bin/yadm

echo "${green}Installing Archive Utilities...${clear}"
sudo dnf install rar unrar p7zip p7zip-plugins unzip -y

echo "${green}Installing rustup, lsd and bob...${clear}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install --git https://github.com/lsd-rs/lsd.git --branch master
cargo install --git https://github.com/MordechaiHadad/bob.git

echo "${green}Installing zoxide...${clear}"
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo "${green}Installing mcfly...${clear}"
curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly

echo "${green}Installing fnm...${clear}"
curl -fsSL https://fnm.vercel.app/install | bash

echo "${green}Installing lazydocker...${clear}"
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

echo "${green}Installing starship...${clear}"
curl -sS https://starship.rs/install.sh | sh

echo "${green}Installing docker...${clear}"
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

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

echo "${green}DONE!🚀🚀${clear}"

