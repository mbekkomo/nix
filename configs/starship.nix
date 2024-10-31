_:
let
  palette = {
    grey = "#a6a6a6";
  };
in
{
  username =
    let
      root = "#ff8533";
      user = "#ffff80";
    in
    {
      style_root = "bold fg:${root}";
      style_user = "bold fg:${user}";
      format = "[$user]($style)";
      show_always = true;
    };

  directory =
    let
      directory = "#668cff";
      readOnly = "#99b3ff";
    in
    {
      style = "bold fg:${directory}";
      read_only_style = "fg:${readOnly}";
      read_only = "";
      format = "[$read_only]($read_only_style)[$path]($style)";
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
    $username [@](grey) $directory
    [ └─╴](grey)$character'';

  palette = "goat";
  palettes.goat = palette;
}
