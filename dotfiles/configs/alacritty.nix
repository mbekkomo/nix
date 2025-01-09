{ ... }:
{
  font.normal = {
    family = "DepartureMono Nerd Font";
    style = "Regular";
  };
  font.size = 11.23;
  font.offset = {
    y = 1;
  };

  window.padding = {
    x = 3;
    y = 2;
  };

  window.opacity = 0.65;
  window.blur = true;

  terminal = {
    shell.program = "/usr/bin/env";
    shell.args = [ "fish" ];
  };

  mouse.hide_when_typing = true;
}
