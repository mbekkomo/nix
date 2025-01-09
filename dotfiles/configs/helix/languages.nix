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
  language-server.ccls.command = "ccls";
  language-server.superhtml = {
    command = "superhtml";
    args = ["lsp"];
  };
  language-server.tailwindcss-langserver = {
    command = "tailwindcss-language-server";
    args = [ "--stdio" ];
    required-root-patterns = [ "tailwind.config.js" ];
  };

  language =
    let
      indent = {
        unit = "  ";
        tab-width = 2;
      };
    in
    [
      {
        name = "html";
        roots = [ ".git" ];
        language-servers = [ "emmet-langserver" "superhtml" ];
      }
      {
        inherit indent;

        name = "civet";
        scope = "source.civet";
        file-types = [ "civet" ];
        comment-tokens = "//";
        block-comment-tokens = [
          {
            start = "/*";
            end = "*/";
          }
          {
            start = "###\n";
            end = "\n###";
          }
        ];
      }
      {
        inherit indent;

        name = "nelua";
        scope = "source.nelua";
        file-types = [ "nelua" ];
        comment-tokens = "--";
        block-comment-tokens = {
          start = "--[[";
          end = "]]";
        };
      }
      {
        name = "c";
        language-servers = [ "ccls" ];
      }
      {
        name = "cpp";
        language-servers = [ "ccls" ];
      }
    ];
}
