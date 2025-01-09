{ root, ... }:
{
  default.mode = "center";
  any.path = toString (root + /etc/wallpapers/default.png);
}
