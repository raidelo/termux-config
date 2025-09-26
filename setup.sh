#!/bin/bash

# Grant storage access permissions to termux
termux-setup-storage

# Install some useful pakages
pkg update
pkg upgrade
pkg install man
pkg install neovim
pkg install vim
pkg install python
pkg install nodejs
pkg install wget
pkg install git
pkg install gh
pkg install uv
pkg install which
pkg install perl
pkg install ripgrep
pkg install nmap
pkg install file
pkg install zip
pkg install unzip

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
pip install requests
pip install bs4
pip install rich
pip install colorama

# Download of Neovim's config
mkdir .config
git clone https://github.com/raidelo/neovim-config.git ./.config/nvim

