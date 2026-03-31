#!/bin/bash
packages=(
  curl
  wget
  htop
  audacity
  blender
  firefox
  neovim
  vim
  dotnet-sdk-10
  treesitter
  lua
  git
  libreoffice
  gnome-boxes
  fish
  fastfetch
)

install() {
  pkg="$1"
  sudo dnf install -y "$pkg"
}

start() {
  for pkg in "${packages[@]}"; do
    echo "Installing $pkg..."
    install "$pkg"
  done
}

# curl -f https://zed.dev/install.sh | sh
flatpack_install() {
    flatpak install flathub com.bitwarden.desktop
    flatpak install -y flathub org.prismlauncher.PrismLauncher
}
rust_install() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
}
bun_install() {
    curl -fsSL https://bun.sh/install | bash
}
ghostty_install() {
    sudo dnf copr enable scottames/ghostty -y
    sudo dnf install -y ghostty
}
firefox_defedora() {
    sudo rm -f /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js
}
nvim_install() {
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak.$(date +%s)" 2>/dev/null || true
    rm -rf "$HOME/.config/nvim"
    git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
    rm -rf "$HOME/.config/nvim/.git"
}
fish_install() {
    # Přidá jen "fish" do .bashrc (pokud tam ještě není)
    if ! grep -q "^fish" ~/.bashrc; then
        echo "fish" >> ~/.bashrc
    fi

    fish -c "set -U fish_greeting"
}
docker_install() {
    curl -fsSL https://get.docker.com | bash
}
sublime_install() {
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
    sudo dnf install sublime-text -y
}

sudo dnf upgrade -y
start
rust_install
nvim_install
firefox_defedora
ghostty_install
bun_install
fish_install
flatpack_install
docker_install
# sublime_install
