{
  config,
  pkgs,
  lib,
  ...
}:
let
  departure-nf = pkgs.departure-mono.overrideAttrs {
    pname = "departure-nerd-font";
    nativeBuildInputs = [ pkgs.nerd-font-patcher ];
    installPhase = ''
      runHook preInstall

      nerd-font-patcher -c *.otf -out $out/share/fonts/otf
      nerd-font-patcher -c *.woff -out $out/share/woff || true
      nerd-font-patcher -c *.woff2 -out $out/share/woff2 || true

      runHook postInstall
    '';
  };
  departure-nf-mono = pkgs.departure-mono.overrideAttrs {
    pname = "departure-nerd-font";
    nativeBuildInputs = [ pkgs.nerd-font-patcher ];
    installPhase = ''
      runHook preInstall

      nerd-font-patcher --mono -c *.otf -out $out/share/fonts/otf
      nerd-font-patcher --mono -c *.woff -out $out/share/woff || true
      nerd-font-patcher --mono -c *.woff2 -out $out/share/woff2 || true

      runHook postInstall
    '';
  };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "24.05";

  boot.loader.systemd-boot.enable = lib.mkDefault false;
  boot.loader.refind.enable = true;
  boot.loader.refind.extraConfig = ''
    include themes/rEFInd-minimal-dark/theme.conf
  '';
  boot.loader.efi.canTouchEfiVariables = true;

  # comment this if something's fucked up
  boot.kernelPackages = pkgs.linuxPackages_zen;

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ "komo" ];
  };

  environment.systemPackages = with pkgs; [
    git
    refind
    gptfdisk
    efibootmgr
    udisks

    # winapps
    podman-compose
  ];

  # winapps
  virtualisation.podman.enable = true;

  # Enable nix-ld
  programs.nix-ld.dev.enable = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [
    "127.0.0.1"
    "::1"
  ];

  services.dnscrypt-proxy2.enable = true;
  services.dnscrypt-proxy2.settings = {
    ipv6_servers = true;
    require_dnssec = true;
    sources.public-resolvers = {
      urls = [
        "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
        "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
      ];
      cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
      minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
    };
    server_names = [
      "mullvad-base-doh"
      "cloudflare"
      "nextdns"
      "nextdns-ipv6"
    ];
  };
  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;

  time.timeZone = "Asia/Makassar";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;

  services.greetd.enable = true;
  programs.regreet.enable = true;

  services.kmscon.enable = true;
  services.kmscon.hwRender = true;
  services.kmscon.fonts = [
    {
      name = "DepartureMono Nerd Font Mono";
      package = departure-nf-mono;
    }
    {
      name = "Noto fonts";
      package = pkgs.noto-fonts;
    }
    {
      name = "Noto fonts (Emoji)";
      package = pkgs.noto-fonts-emoji;
    }
  ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  security.pam.services.hyprlock = { };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh.enable = true;

  services.resolved.enable = false;

  services.flatpak.enable = true;
  services.flatpak.packages = [
    "io.github.zen_browser.zen" # Browser
    "io.github.equicord.equibop" # Discord
    "im.nheko.Nheko" # Matrix
    "dev.toastbits.spmp" # Music
    "com.interversehq.qView"
    "io.itch.itch"
    "com.valvesoftware.Steam"
    { flatpakref = "https://sober.vinegarhq.org/sober.flatpakref"; }
  ];

  services.udisks2.enable = true;

  services.cloudflare-warp.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
  ];

  users.users.komo = {
    isNormalUser = true;
    description = "Komo";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    departure-nf
    departure-nf-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
