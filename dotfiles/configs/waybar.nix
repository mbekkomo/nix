{ root, ... }:
let
  colorScheme = {
  };

  nfIcon = x: ''<b class="nf ${x}"></b>'';
in
{
  mainBar = {
    reload_style_on_change = true;
    height = 20;
    spacing = 4;
  
    modules-left = [
      "hyprland/workspaces"
      "hyprland/submap"
    ];

    modules-center = [
      "hyprland/window"
    ];

    modules-right = [
      "mpd"
      "idle_inhibitor"
      "pulseaudio"
      "network"
      "power-profiles-daemon"
      "cpu"
      "memory"
      "temperature"
      "backlight"
      "keyboard-state"
      "hyprland/language"
      "battery"
      "battery#bat2"
      "clock"
      "tray"
    ];

    # modules-left = [
    #   "clock"
    # ];

    # modules-center = [
    #   "hyprland/window"
    # ];

    # "hyprland/window" = {
    #   rewrite = {
    #     "(.*) — Zen Browser" = ''${nfIcon "nf-fa-globe"} $1'';
    #   };
    # };
  };
}
