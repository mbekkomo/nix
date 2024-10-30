_: {
  theme = "tokyonight";

  editor = {
    true-color = true;
    mouse = false;
    scroll-lines = 2;
    line-number = "relative";
    cursorline = true;
    bufferline = "multiple";
    color-modes = true;
    default-line-ending = "lf";
    popup-border = "all";
    preview-completion-insert = false;
  };

  editor.lsp = {
    display-messages = true;
    display-inlay-hints = true;
  };

  editor.statusline = {
    mode = {
      normal = "[N]";
      insert = "[I]";
      select = "[S]";
    };
    center = [
      "read-only-indicator"
      "file-base-name"
      "file-modification-indicator"
    ];
    left = [
      "mode"
      "spacer"
      "spinner"
      "spacer"
      "diagnostics"
    ];
    right = [
      "file-type"
      "file-encoding"
      "position"
      "version-control"
    ];
  };

  editor.cursor-shape = {
    insert = "bar";
    select = "hidden";
  };

  editor.indent-guides = {
    render = true;
    character = "╎";
    skip-levels = 2;
  };

  editor.soft-wrap = {
    enable = true;
    max-wrap = 25;
    max-indent-retain = 0;
  };
}
