{
  config,
  lib,
  pkgs,
  etcpkgs,
  ...
}:
let
  username = "komo"; # change to your username
  homeDir = "/home/${username}";
  wrapGL = config.lib.nixGL.wrap;
  # https://github.com/NixOS/nixpkgs/pull/313760#issuecomment-2365160954
  bun = pkgs.bun.overrideAttrs rec {
    passthru.sources."x86_64-linux" = pkgs.fetchurl {
      url = "https://github.com/oven-sh/bun/releases/download/bun-v${pkgs.bun.version}/bun-linux-x64-baseline.zip";
      hash = "sha256-FwkVP5lb2V9E8YGPkTAqVMsZmaZXMq8x5AR+99cuIX0=";
    };
    src = passthru.sources."x86_64-linux";
  };
in
{
  programs.home-manager.enable = true;
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "24.05"; # do not change

  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "node" ''
      exec ${bun.out}/bin/bun "$@"
    '')
    etcpkgs.nix-search

    nixfmt-rfc-style
    shellcheck
    moar
    glow
    fzf
    ripgrep
    fd
    sd
    zoxide
  ];

  home.file = {
    ".config/alacritty/themes/tokyonight.toml".source = ./configs/alacritty/tokyonight.toml;
    ".fonts/departuremono-nerdfont.otf".source = ./fonts/DepartureMonoNerdFont-Regular.otf;
    ".local/share/lscolors.fish".source = ./etc/lscolors.fish;
  };

  home.sessionVariables = {
    "SUDO_PROMPT" = "[sudo 🐺] %p: ";
    "PAGER" = "moar";
    "EDITOR" = "hx";
  };

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      allowed-users = [ username ];
    };
  };

  nixGL = {
    packages = etcpkgs.nixGLPackages;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua-language-server
      nil
      bash-language-server
    ];
    settings = import ./configs/helix.nix { };
    languages = import ./configs/hx-langs.nix { };
  };

  programs.alacritty = {
    enable = true;
    package = wrapGL pkgs.alacritty;
    settings = import ./configs/alacritty.nix { themeDir = "${homeDir}/.config/alacritty/themes"; };
  };

  programs.zellij = {
    enable = true;
    settings = import ./configs/zellij.nix { };
  };

  programs.bun = {
    enable = true;
    package = bun;
  };

  programs.starship = {
    enable = true;
    settings = import ./configs/starship.nix { };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      zoxide init fish | source
      source ~/.local/share/lscolors.fish
    '';
    plugins = 
    let
      plugin = x: {
        name = x.name;
        src = x.src;
      };
    in
    with pkgs.fishPlugins; [
      (plugin done)
      (plugin colored-man-pages)
      (plugin fifc)
      (plugin autopair)
      (plugin git-abbr)
      (plugin fzf-fish)
    ];
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    extraOptions = [
      "--color=auto"
    ];
  };

  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
    userName = "Komo";
    userEmail = "71205197+mbekkomo@users.noreply.github.com";
    extraConfig = {
      color.ui = true;
      color.diff-highlight = rec {
        oldNormal = [
          "red"
          "bold"
        ];
        oldHighlight = oldNormal ++ [ "52" ];
        newNormal = [
          "green"
          "bold"
        ];
        newHighlight = newNormal ++ [ "22" ];
      };
      color.diff = {
        meta = [ "11" ];
        frag = [
          "magenta"
          "bold"
        ];
        func = [
          "146"
          "bold"
        ];
        commit = [
          "yellow"
          "bold"
        ];
        old = [
          "red"
          "bold"
        ];
        new = [
          "green"
          "bold"
        ];
        whitespace = [
          "red"
          "bold"
        ];
      };
    };
  };

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-poi
      gh-eco
      gh-screensaver
      gh-s
      gh-f
      gh-notify
      gh-markdown-preview
    ];
    settings.aliases = {
      rcl = "repo clone";
      rfk = "repo fork";
      rmv = "repo rename";
      rdl = "repo delete --yes";
    };
  };

  services.git-sync = {
    enable = true;
    repositories."dotfiles" = {
      path = "${homeDir}/dotfiles";
      uri = "https://github.com/mbekkomo/dotfiles.git";
    };
  };

  services.arrpc.enable = true;
}
