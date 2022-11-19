#!/bin/sh

apt upgrade

echo "====================="
echo "zsh"
echo "====================="
apt install zsh && chsh -s /bin/zsh root && chsh && su - root
echo $SHELL

echo "====================="
echo "git install"
echo "====================="
apt install git && git --version && git config --global user.name takuyawww && git config --global user.email wakataku.11010809@gmail.com

echo "====================="
echo "git setup"
echo "====================="
ls -al ~/.ssh
ssh-keygen -t ed25519 -C "wakataku.11010809@gmail.com"
ls -al ~/.ssh
eval "$(ssh-agent -s)"
cat ~/.ssh/id_ed25519.pub
echo "please setting GitHub GUI (to https://github.com/settings/keys"
read Wait
ssh -T git@github.com

echo "====================="
echo "workspace"
echo "====================="
cd ../ && mkdir home/workspace && cd home/workspace
git clone git@github.com:takuyawww/dotfiles.git
./dotfiles/linked.sh
git clone git@github.com:takuyawww/zonotech.git
apt install vim

echo "====================="
echo "ruby"
echo "====================="
# https://www.aise.ics.saitama-u.ac.jp/~gotoh/RubyByRbenvOnUbuntu2004.html
apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
apt install -y gcc g++ make 
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo "# rbenv" >> ~/.zshrc
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(~/.rbenv/bin/rbenv init -)"' >> ~/.zshrc

source ~/.zshrc
source ~/.vimrc

which rbenv
rbenv install 3.1.2
rbenv rehash
rbenv global 3.1.2
ruby -v
which ruby
which gem
gem --version
gem update --system

echo "====================="
echo "golang"
echo "====================="
apt install golang
go version

echo "====================="
echo "node"
echo "====================="
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

source ~/.zshrc
source ~/.vimrc

nvm list
nvm install v18.12.1
node -v

# https://classic.yarnpkg.com/lang/en/docs/install/#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
export PATH="$PATH:/opt/yarn-[version]/bin"

