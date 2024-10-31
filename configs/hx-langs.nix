_: {
  language-server.nil = {
    config = {
      nil.formatting.command = [ "nixfmt" ];
    };
  };

  language-server.emmet-langserver = {
    command = "emmet-language-server";
    args = [ "--stdio" ];
  };

  language = [
    {
      name = "html";
      roots = [ ".git" ];
      language-servers = [ "emmet-langserver" ];
    }
  ];
}
