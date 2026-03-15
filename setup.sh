#!/usr/bin/env bash

set -e

# --------------------------------------------------
# Grant storage access permissions to Termux
# --------------------------------------------------
termux-setup-storage

# --------------------------------------------------
# Install useful packages
# --------------------------------------------------
pkg update -y
pkg upgrade -y

pkg install -y \
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
  tree \
  fd \
  fzf \
  lazygit \
  termux-api

# --------------------------------------------------
# Git global configuration
# Default branch, user identity and useful aliases
# --------------------------------------------------
git config --global init.defaultBranch main
git config --global user.email "raidelosix@gmail.com"
git config --global user.name "raidelo"

git config --global alias.lodag "log --oneline --decorate --all --graph"
git config --global alias.ll lodag
git config --global alias.co checkout
git config --global alias.ss status

git config --global core.editor nvim

# --------------------------------------------------
# Python utilities
# Install commonly used libraries
# --------------------------------------------------
python -m pip install --upgrade pip
pip install requests bs4 rich colorama

# --------------------------------------------------
# Neovim setup
# Clone personal Neovim configuration
# --------------------------------------------------
mkdir -p ~/.config

if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/raidelo/neovim-config.git ~/.config/nvim
fi

# --------------------------------------------------
# Terminal font setup
# Download and apply JetBrainsMono Nerd Font (Termux)
# --------------------------------------------------
URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts"
FONT="/JetBrainsMono/NoLigatures/Regular/JetBrainsMonoNLNerdFontMono-Regular.ttf"

wget --show-progress -q \
  -O ~/.termux/font.ttf \
  "${URL}${FONT}"

termux-reload-settings

# --------------------------------------------------
# Bash configuration
# Aliases and environment variables
# --------------------------------------------------
BASHRC_BLOCK=$(
  cat <<'EOF'
# --------------------------------------------------
# Shell aliases
# Shortcuts for common terminal commands
# --------------------------------------------------
alias cls=clear
alias ll="ls -la"
alias la="ls -a"


# --------------------------------------------------
# Neovim configuration management
# Backup, restore and remove Neovim config/data/cache
# --------------------------------------------------
alias nvim-backup-create="mv ~/.config/nvim{,.bak} && mv ~/.local/share/nvim{,.bak} && mv ~/.local/state/nvim{,.bak} && mv ~/.cache/nvim{,.bak}"
alias nvim-backup-restore="mv ~/.config/nvim{.bak,} && mv ~/.local/share/nvim{.bak,} && mv ~/.local/state/nvim{.bak,} && mv ~/.cache/nvim{.bak,}"
alias nvim-delete="rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim"
alias nvim-backup-delete="rm -rf ~/.config/nvim.bak ~/.local/share/nvim.bak ~/.local/state/nvim.bak ~/.cache/nvim.bak"


# --------------------------------------------------
# GitHub configuration
# Base SSH path for personal repositories
# --------------------------------------------------
GH_REPO="git@github.com:raidelo"

EOF
)

# Add block only if it doesn't already exist
grep -q "GH_REPO=\"git@github.com:raidelo\"" ~/.bashrc || echo "$BASHRC_BLOCK" >>~/.bashrc

source ~/.bashrc

# --------------------------------------------------
# Authenticate GitHub account
# --------------------------------------------------
gh auth login
