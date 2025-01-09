#!/usr/bin/env bash

nix() {
  command nix --extra-experimental-features "nix-command flakes" "$@"
}
export -f nix

task.switch() {
  local locked_hm
  locked_hm="$(nix eval --impure --raw --expr '(builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.home-manager.locked.rev')"
  [[ -n "$1" ]] && export NIXPKGS_SYSTEM="$1"
  nix run github:nix-community/home-manager/"${locked_hm}" -- switch --impure --flake .#goat
}
