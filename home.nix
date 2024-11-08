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
      hash = "sha256-WNmOGBrDDrW+8D/iMJjv10BUz0yjUEK+BY7aqBG9R9o=";
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

    (wrapGL blackbox-terminal)

    nixfmt-rfc-style
    shellcheck
    moar
    glow
    fzf
    ripgrep
    fd
    sd
    zoxide
    bat
    sigi
  ];

  home.file = {
    ".config/alacritty/themes/tokyonight.toml".source = ./configs/alacritty/tokyonight.toml;
    ".local/share/blackbox/schemes/tokyonight.json".source = ./etc/blackbox/tokyonight.json;
    ".local/share/fonts/departuremono-nerdfont.otf".source = ./fonts/DepartureMonoNerdFont-Regular.otf;
    ".config/zls.json".text = builtins.toJSON (import ./configs/zls.nix { });

    ".config/fish/lscolors.fish".source = ./etc/lscolors.fish;
    ".config/fish/functions/nixs.fish".source = ./shells/nixs.fish;
    ".config/fish/functions/nixd.fish".source = ./shells/nixd.fish;
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
    gc.automatic = true;
  };

  nixGL = {
    packages = etcpkgs.nixGLPackages;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };

  services.git-sync = {
    enable = true;
    repositories."nix" = {
      path = "${homeDir}/nix";
      uri = "https://github.com/mbekkomo/nix.git";
    };
  };

  services.arrpc.enable = true;

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua-language-server
      nil
      bash-language-server
      emmet-language-server
      zls
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
      source ~/.config/fish/lscolors.fish

      set -Ux fifc_editor hx

      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_replace underscore
      set fish_cursor_visual block
    '';
    plugins =
      let
        plugin = x: {
          name = x.name;
          src = x.src;
        };
      in
      with pkgs.fishPlugins;
      [
        (plugin done)
        (plugin colored-man-pages)
        (plugin fifc)
        (plugin autopair)
        (plugin git-abbr)
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
}
