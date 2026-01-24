#!/usr/bin/env bash
set -euo pipefail

# Paths
SOFTETHER_DIR="$HOME/.softether"
DEVSHELL_DIR="$HOME/.config/nix/dev-shells/softether"
REPO_URL="https://github.com/SoftEtherVPN/SoftEtherVPN.git"

if [ "$EUID" -ne 0 ]; then
    sudo -v
fi

if [ -d "$SOFTETHER_DIR" ]; then
  echo "Error: $SOFTETHER_DIR already exists."
  exit 1
fi

nix develop "$DEVSHELL_DIR/#softether" --command bash -c "
    set -euo pipefail

    mkdir -p "$SOFTETHER_DIR"
    git clone "$REPO_URL" "$SOFTETHER_DIR"

    cd "$SOFTETHER_DIR"
    git submodule init && git submodule update
    ./configure
    make -C build
    sudo make -C build install

    exit
"

echo "SoftEther is installed."
