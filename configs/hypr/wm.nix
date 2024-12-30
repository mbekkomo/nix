{ pkgs, root, ... }:
let
  terminal = "alacritty";
  runner = "wofi --show drun";

  cursor_size = 30;
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

  windowrulev2 = [
    "float, class:(clipse)"
    "size 622 652, class:(clipse)"
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
      "CTRL + SUPER, P, exec, ${passmenu}"
      "CTRL + SUPER, R, exec, ${passmenu} -o"
    ];

  bindel = [
    ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%+"
    ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%-"
  ];
}
