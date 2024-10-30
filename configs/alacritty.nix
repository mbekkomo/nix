{ themeDir, ... }:
let
  theme = "tokyonight";
in
{
  general.import = [ "${themeDir}/${theme}.toml" ];

  font.normal = {
    family = "DepartureMono Nerd Font";
    style = "Regular";
  };
  font.size = 11.23;
  font.offset = {
    y = 1;
  };

  window.dynamic_padding = true;

  terminal = {
    shell.program = "/usr/bin/env";
    shell.args = [ "fish" ];
  };
}
