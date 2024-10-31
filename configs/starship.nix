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
    in
    {
      style = "bold fg:${directory}";
      read_only = " ";
      format = "[$read_only]($style)[$path]($style)";
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

  git_branch =
    let
      symbol = "";
      branch = "#cc66ff";
    in
    {
      symbol = "${symbol} ";
      style = "bold fg:${branch}";
      format = "[$symbol$branch(:$remote_branch)]($style)";
    };

  fill.symbol = " ";

  format =
    let
      dot = "[🞄](grey)";
    in
    ''
      $username [@](grey) $directory$fill${
        # prevent nixfmt from formatting this line
        "($git)"
        #
        + ""
      }
      [ └─╴](grey)$character'';

  palette = "goat";
  palettes.goat = palette;
}
