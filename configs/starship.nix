_:
let
  palette = {
    grey = "bg:#a6a6a6";
  };
in
{
  username = {
    style_root = "bold fg:#ff8533";
    style_user = "bold fg:#ffff4d";
    format = "[$user]($style)";
    show_always = true;
  };

  character =
    let
      symbol = "🞂";
      viSymbol = "V";
    in
    {
      success_symbol = "[${symbol}](bold green)";
      error_symbol = "[${symbol}](bold red)";
      vimcmd_symbol = "[${viSymbol}](bold green)";
      vimcmd_replace_one_symbol = "[${viSymbol}](bold purple)";
      vimcmd_replace_symbol = "[${viSymbol}](bold purple)";
      vimcmd_visual_symbol = "[${viSymbol}](bold yellow)";
    };

  format = ''
    $username
    [ └─╴](grey)$character'';

  palette = "goat";
  palettes.goat = palette;
}
