{ pkgs, root, ... }:
let
  terminal = "alacritty";
  runner = "wofi --show drun";

  cursor_size = 30;

  makeEnv = x: builtins.mapAttrs (name: value: [ "${name},${value}" ]) x;
in
{
  exec-once = [
    terminal
    "systemctl --user start dunst.service"
    "systemctl --user start hyprpolkitagent.service"
    "systemctl --user start hypridle.service"
    "wpaperd -d"
    "${pkgs.wluma}/bin/wluma &"
    "clipse -listen"
  ];

  monitor = ",preferred,auto,auto";

  env = [
    "XCURSOR_SIZE,${toString cursor_size}"
    "HYPRCURSOR_SIZE,${toString cursor_size}"
  ];

  general = {
    gaps_in = 5;
    gaps_out = 20;

    border_size = 2;

    resize_on_border = true;

    allow_tearing = false;

    layout = "dwindle";
  };

  windowrulev2 = let
    clipse = "(clipse)";
    sober = "(org.vinegarhq.Sober)";
    portal = "(xdg-desktop-portal-.*)";
  in [
    "float, class:${clipse}"
    "size 622 652, class:${clipse}"
    "pin, class:${clipse}, title:(Sober)"
    # *** Sober -> Fix the external UI
    "float, class:${sober}, title:negative:(Sober)"
    "size 900 688, class:${sober}, title:negative:(Sober)"
    "move onscreen, class:${sober}, title:negative:(Sober)"
    "center, class:${sober}, title:negative:(Sober)"
    "noborder 1, class:${sober}, title:negative:(Sober)"
    # ***
    "fullscreen, class:${sober}" # Might resolve the shiftlock issue
    # *** Make selection more appropriate
    "float, class:${portal}"
    "size 725 443, class:${portal}"
    "move onscreen, class:${portal}"
    "center, class:${portal}"
  ];

  bind =
    let
      passmenu = toString (root + /bin/passmenu);
    in
    [
      "SUPER, PRINT, exec, hyprshot -m window"
      ", PRINT, exec, hyprshot -m output"
      "SHIFT + SUPER, PRINT, exec, hyprshot -m region"

      "SHIFT + SUPER, V, exec, alacritty --class clipse -e clipse"

      "SHIFT + SUPER, R, exec, kooha"

      "CTRL + SUPER, P, exec, ${passmenu}"
      "CTRL + SUPER, R, exec, ${passmenu} -o"
    ];

  bindel = [
    ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%+"
    ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%-"
  ];
}
