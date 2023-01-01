# Font (MacOS)
# cd ./Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
# docker container run -it --rm --name ubuntu -p 3000:3000 -p 5000:5000 ubuntu:latest bin/bash
# docker container exec -it ubuntu zsh

echo "-----------------------------------------"
apt update && apt install zsh sudo jq tree wget curl neovim gnupg2 ripgrep

# neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
which nvim

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
mkdir ~/.config
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
cd dotfiles && ./linked.sh && source ~/.zshrc
git config --global user.name takuyawww && git config --global user.email wakataku.11010809@gmail.com

echo "-----------------------------------------"
sudo apt update && sudo apt install golang && go version

echo "-----------------------------------------"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
source ~/.zshrc
nvm install v18.12.1
node -v

sudo apt update
sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
export PATH="$PATH:/opt/yarn-[version]/bin"
sudo apt install yarn
source ~/.zshrc
yarn -v

# lsp
cd ~ && yarn global add typescript-language-server typescript && export PATH="$PATH:/home/dev/.yarn/bin"
