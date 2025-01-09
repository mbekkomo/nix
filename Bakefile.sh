#!/usr/bin/env bash

nix() {
  command nix --extra-experimental-features "nix-command flakes" "$@"
}
export -f nix

task.switch-hm() {
  local locked_hm
  locked_hm="$(nix eval --impure --raw --expr '(builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.home-manager.locked.rev')"
  nix run github:nix-community/home-manager/"$locked_hm" -- switch --flake .
}

task.switch-nixos() {
  local config="${1:-$(
    sed 's| |-|g' /sys/devices/virtual/dmi/id/product_name
  )}"
  nixos-rebuild switch --flake .#"$config" --impure "$@"
}

task.boot-nixos() {
  local config="${1:-$(
    sed 's| |-|g' /sys/devices/virtual/dmi/id/product_name
  )}"
  nixos-rebuild boot --flake .#"$config" --impure "$@"
}

task.switch-nix-on-droid() {
  local config="${1:-$(getprop ro.product.vendor.model)}"
  nix-on-droid switch --flake .#"$config"
}

task.list-nixos() {
  echo
  echo "NixOS configurations:"
  grep nixosConfigurations flake.nix |
    awk -F' ' '/.+/ { print $1; }' |
    awk -F. '/.+/ { print $2; }' |
    sed 's/^/ - /'
  echo
}

task.list-nix-on-droid() {
  echo
  echo "nix-on-droid configurations:"
  grep nixOnDroidConfigurations flake.nix |
    awk -F' ' '/.+/ { print $1; }' |
    awk -F. '/.+/ { print $2; }' |
    sed 's/^/ - /'
  echo
}
