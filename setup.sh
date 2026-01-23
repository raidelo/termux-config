#!/bin/bash

# Grant storage access permissions to termux
termux-setup-storage

# Install some useful pakages
pkg update && pkg upgrade && pkg install -y \
  man \
  neovim \
  vim \
  python \
  nodejs \
  wget \
  git \
  gh \
  uv \
  which \
  perl \
  ripgrep \
  nmap \
  file \
  zip \
  unzip \
  termux-api

# Set up some Git's configurations
git config set --global init.defaultBranch main
git config set --global user.email raidelosix@gmail.com
git config set --global user.name raidelo
git config set --global alias.lodag "log --oneline --decorate --all --graph"
git config set --global alias.ll lodag
git config set --global alias.co checkout
git config set --global alias.ss status
git config set --global core.editor nvim

# Install some Python's useful libraries
pip install requests bs4 rich colorama

# Download of Neovim's config
mkdir -p ~/.config
git clone https://github.com/raidelo/neovim-config.git ~/.config/nvim

# Download and set a NerdFont
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Cousine.zip
mkdir Cousine
chmod -R u=rwx Cousine
unzip Cousine.zip -d Cousine
mv Cousine/CousineNerdFontMono-Regular.ttf ~/.termux/font.ttf
rm -rf Cousine
rm Cousine.zip
termux-reload-settings

# Set aliases for some commands
t = "# Setting some aliases\n"
t += "alias cls=clear\n"
t += "alias ll=\"ls -la\"\n"
t += "alias la=\"ls -a\"\n"
echo t >>~/.bashrc
source ~/.bashrc

# Authenticate GitHub account
gh auth login
