#!/bin/zsh

# docker image build --no-cache -t my-ubuntu:latest --progress=plain .
# docker container run -it --rm --name ubuntu -p 3000:3000 -p 5000:5000 -p 8080:8080 my-ubuntu zsh

mkdir .ssh && ssh-keygen -t ed25519 -C "wakataku.11010809@gmail.com"
eval "$(ssh-agent -s)"
cat ~/.ssh/id_ed25519.pub
echo "https://github.com/settings/keys"
read Wait
ssh -T git@github.com
git config --global user.name takuyawww && git config --global user.email wakataku.11010809@gmail.com

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh

mkdir ~/.config
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

cd workspace && git clone git@github.com:takuyawww/dotfiles.git && cd dotfiles
./linked.sh && cd ~ &&source ~/.zshrc

nvm install v18.12.1

yarn global add typescript-language-server typescript && export PATH="$PATH:/home/dev/.yarn/bin"

zsh