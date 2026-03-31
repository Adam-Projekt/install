#!/bin/bash

# ====== CONFIG ======
packages=(
  firefox
  neovim
  vim
  dotnet-sdk-10
  treesitter
  lua
  git
)

# ====== default install ======
install() {
  pkg="$1"
  sudo dnf install -y "$pkg"
}

# ====== loop ======
start() {
  for pkg in "${packages[@]}"; do
    echo "Installing $pkg..."
    install "$pkg"
  done
}

special() {
    curl -fsSL https://bun.sh/install | bash
    sudo rm -f /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js
    # ghostty
  sudo dnf copr enable scottames/ghostty -y
  sudo dnf install -y ghostty

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source "$HOME/.cargo/env"

  # curl -f https://zed.dev/install.sh | sh

  sudo dnf install -y gnome-boxes

  sudo dnf install -y libreoffice

  flatpak install -y flathub org.prismlauncher.PrismLauncher

  #curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh && rm get-docker.sh
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak.$(date +%s)" 2>/dev/null || true
  rm -rf "$HOME/.config/nvim"
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"

  flatpak install flathub com.bitwarden.desktop


}

sudo dnf upgrade -y
#start
special
