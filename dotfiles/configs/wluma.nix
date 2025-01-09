{ ... }:
{
  als.none = { };
  output.backlight = [
    {
      name = "eDP-1";
      path = "/sys/class/backlight/intel_backlight";
      capturer = "wayland";
    }
  ];
}
