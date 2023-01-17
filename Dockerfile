FROM ubuntu:latest

EXPOSE 80 3000 5000

RUN apt -y update && apt -y upgrade
RUN apt install -y \
      sudo \
      zsh \
      locales \
      git \
      jq \
      tree \
      wget \
      curl \
      gnupg2 \
      ripgrep \
      openssl \
      software-properties-common \
      lsof \
      golang-go

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    ./squashfs-root/AppRun --version && \
    ln -s /squashfs-root/AppRun /usr/bin/nvim

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt -y update && apt -y upgrade && apt install -y yarn

RUN useradd dev -s /bin/zsh -m -d /home/dev -G sudo && \
    echo "dev:dev" | chpasswd

COPY setup.sh /home/dev/

RUN chown dev /home/dev/setup.sh && chmod 755 /home/dev/setup.sh

USER dev

WORKDIR /home/dev

RUN mkdir workspace

ENV GOPATH=/home/dev/workspace/go

ENTRYPOINT ["./setup.sh"]
