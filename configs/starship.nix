_: {
  username = {
    style_root = "bold fg:#ff8533";
    style_user = "bold fg:#ffff4d";
    format = "[$user]($style)";
    show_always = true;
  };

  character =
  let
    symbol = "▲";
  in
  {
    success_symbol = "[▲](bold green)";
    error_symbol = "[▲](bold red)";
  };

  format = ''
  $username
  $character'';
}
