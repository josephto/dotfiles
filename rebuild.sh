#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
ln -sfn "$DIR" ~/.dotfiles
HOST="${1:-macbook}"  # macbook (personal) or work
exec sudo nix run nix-darwin -- switch --flake ~/.dotfiles#$HOST
