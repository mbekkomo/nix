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
      format = "([$symbol$branch(:$remote_branch)]($style) )";
    };

  git_commit =
    let
      symbol = "";
      commit = "#4dff4d";
    in
    {
      tag_symbol = " ${symbol} ";
      style = "bold fg:${commit}";
    };

  git_state.style = "bold fg:#66ffe0";

  git_status =
    let
      conflicted = "󰦍";
      ahead = "󱊽";
      behind = "󱊾";
      renamed = "󰏫";
      deleted = "";
    in
    {
      inherit conflicted;
      inherit ahead;
      inherit behind;
      inherit renamed;
      inherit deleted;
    };

  env_var.NIX_SHELL =
    let
      symbol = "󱄅";
    in {
      inherit symbol;
      style = "bold fg:110";
      format = "[$symbol]($style) ";
    };

  fill.symbol = " ";

  format =
    let
      dot = "[🞄](grey)";
    in
    ''
      $battery''${env_var.NIX_SHELL}$username [@](grey) $directory$fill${
        # prevent nixfmt from formatting this line
        "$git_branch$git_commit$git_state$git_metrics$git_status"
        #
        # + "$cmd_duration"
      }
      [ └─╴](grey)$character'';

  palette = "goat";
  palettes.goat = palette;
}
