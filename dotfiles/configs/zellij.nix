{ pkgs, ... }:
{
  default_shell = "fish";
  scrollback_editr = "${pkgs.micro}/bin/micro";
}
