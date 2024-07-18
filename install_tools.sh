#!/bin/bash

# NixOS Development Environment Setup Script

# Ensure NixOS is up to date
sudo nix-channel --update
sudo nixos-rebuild switch --upgrade

# Add necessary channels
sudo nix-channel --add https://nixos.org/channels/nixos-23.05 nixos
sudo nix-channel --update

# Install base development tools
nix-env -iA nixpkgs.git nixpkgs.gcc nixpkgs.gcc11 nixpkgs.makeWrapper

# Install programming languages and compilers
nix-env -iA nixpkgs.ruby nixpkgs.go nixpkgs.rustup nixpkgs.openjdk nixpkgs.dotnet-sdk

# Set up environment variables for Go
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export GOROOT=/run/current-system/sw/bin/go' >> ~/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc

# Install additional development tools
nix-env -iA nixpkgs.cmake nixpkgs.gdb nixpkgs.valgrind nixpkgs.bash-completion nixpkgs.nodejs nixpkgs.yarn nixpkgs.postgresql nixpkgs.mysql nixpkgs.sqlite nixpkgs.coreutils nixpkgs.curl nixpkgs.wget nixpkgs.man-db nixpkgs.man-pages nixpkgs.htop nixpkgs.docker nixpkgs.docker-compose nixpkgs.python3 nixpkgs.python3Packages.virtualenv nixpkgs.nodejs nixpkgs.typescript nixpkgs.boost nixpkgs.qt5 nixpkgs.qt6 nixpkgs.gtk3

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group
sudo usermod -aG docker $USER

# Create a scripts directory and add it to PATH
mkdir -p ~/scripts
echo 'export PATH="$HOME/scripts:$PATH"' >> ~/.bashrc

# Install additional useful tools
nix-env -iA nixpkgs.neovim nixpkgs.tmux nixpkgs.zsh

# Set up Oh My Zsh (optional but recommended)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
source ~/.zshrc

# Install Nix Software Center
nix-env -iA nixpkgs.nix-software-center

# Final system update and cleanup
sudo nixos-rebuild switch --upgrade

echo "Installation complete! Please log out and log back in for all changes to take effect."
echo "After logging back in, launch JetBrains Toolbox to install your preferred IDEs."
echo "Don't forget to configure your IDEs and tools as needed."
