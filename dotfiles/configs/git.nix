_: {
  color.ui = true;
  color.diff-highlight = rec {
    oldNormal = [
      "red"
      "bold"
    ];
    oldHighlight = oldNormal ++ [ "52" ];
    newNormal = [
      "green"
      "bold"
    ];
    newHighlight = newNormal ++ [ "22" ];
  };
  color.diff = {
    meta = [ "11" ];
    frag = [
      "magenta"
      "bold"
    ];
    func = [
      "146"
      "bold"
    ];
    commit = [
      "yellow"
      "bold"
    ];
    old = [
      "red"
      "bold"
    ];
    new = [
      "green"
      "bold"
    ];
    whitespace = [
      "red"
      "bold"
    ];
  };

  push.autoSetupRemote = true;
}
