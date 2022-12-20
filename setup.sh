# docker container run -it --rm --name ubuntu -p 3000:3000 ubuntu:latest bin/bash

echo "-----------------------------------------"
apt update && apt install zsh sudo jq tree wget curl vim gnupg2

useradd dev -s /bin/zsh -m -d /home/dev && usermod -G sudo dev && passwd dev && su dev

echo "-----------------------------------------"
cd ~
sudo apt update && sudo apt install git && git --version
mkdir .ssh && ssh-keygen -t ed25519 -C "wakataku.11010809@gmail.com"
eval "$(ssh-agent -s)"
cat ~/.ssh/id_ed25519.pub
echo "go to https://github.com/settings/keys"
read Wait
ssh -T git@github.com

echo "-----------------------------------------"
git clone git@github.com:takuyawww/dotfiles.git
cd dotfiles && ./linked.sh && source ~/.zshrc
git config --global user.name takuyawww && git config --global user.email wakataku.11010809@gmail.com

echo "-----------------------------------------"
sudo apt update && sudo apt install golang && go version

echo "-----------------------------------------"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
source ~/.zshrc
nvm install v18.12.1
node -v

apt update
sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
export PATH="$PATH:/opt/yarn-[version]/bin"
sudo apt install yarn
source ~/.zshrc
yarn -v
