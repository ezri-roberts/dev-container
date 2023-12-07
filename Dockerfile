FROM ubuntu:latest

# Update system and install packages.
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y software-properties-common && \
add-apt-repository ppa:neovim-ppa/unstable
RUN apt update -y && apt install -y \
pkg-config sudo bash curl wget git zsh tmux neovim unzip \
gcc meson nodejs npm golang-go python3 lua5.3 make cmake default-jdk \
xauth libglfw3 libglfw3-dev libc6-dev libgl1-mesa-dev \
libxcursor-dev libxi-dev libxinerama-dev libxrandr-dev \
libxxf86vm-dev libasound2-dev libglu1-mesa-dev \
mesa-common-dev xorg-dev

# Ripgrep
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
RUN dpkg -i ripgrep_13.0.0_amd64.deb && rm ripgrep_13.0.0_amd64.deb

### Configs ###
RUN mkdir ~/.config

# ZSH
RUN git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
RUN git clone https://gitlab.com/Moncii/zsh-config.git ~/.config/zsh
RUN ln -s ~/.config/zsh/zshrc ~/.zshrc
RUN echo export LC_ALL=en_IN.UTF-8 >> $HOME/.profile
RUN echo export LANG=en_IN.UTF-8 >> $HOME/.profile

# Tmux
RUN git clone https://gitlab.com/Moncii/tmux-config.git ~/.config/tmux

# LazyVim
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim
RUN rm -rf ~/.config/nvim/.git

WORKDIR /root/proj

ENTRYPOINT ["zsh"]
