#!/bin/zsh

# docker image build --no-cache -t my-ubuntu:latest --progress=plain .
# docker container run -it --rm --name ubuntu -p 3000:3000 -p 5000:5000 -p 8080:8080 my-ubuntu zsh
# docker container exec -it ubuntu zsh

mkdir .ssh && ssh-keygen -t ed25519 -C "wakataku.11010809@gmail.com"
eval "$(ssh-agent -s)"
cat ~/.ssh/id_ed25519.pub
echo "https://github.com/settings/keys"
read Wait
ssh -T git@github.com
git config --global user.name takuyawww && \
git config --global user.email wakataku.11010809@gmail.com && \
git config --global core.editor nvim

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh

mkdir ~/.config
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

cd workspace && \
git clone git@github.com:takuyawww/dotfiles.git && \
./dotfiles/linked.sh && \
source ~/.zshrc

nvm install v18.12.1

yarn global add typescript-language-server typescript && export PATH="$PATH:/home/dev/.yarn/bin"

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
rm lazygit.tar.gz

sudo sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen && \
sudo locale-gen

go install golang.org/x/tools/gopls@latest
export PATH="$PATH:$GOPATH/bin"

zsh
