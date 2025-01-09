task.switch() {
  nixos-rebuild switch --flake .#goat --impure "$@"
}

task.boot() {
  nixos-rebuild boot --flake .#goat --impure "$@"
}
