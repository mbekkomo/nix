#!/usr/bin/env bash

nix() {
  command nix --extra-experimental-features "nix-command flakes" "$@"
}
export -f nix

task.switch() {
  nix run github:nix-community/home-manager -- switch --impure --flake .#goat
}

task.fmt() {
  nix run nixpkgs#fd -- -e nix -x run nixpkgs#nixfmt-rfc-style
}
