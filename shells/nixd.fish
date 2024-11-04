function nixd
nix develop $argv --command env NIX_SHELL=_ fish
end
