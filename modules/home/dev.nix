{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.development.enable = lib.mkEnableOption "Enable development module";
  config = lib.mkIf config.development.enable {
    home.packages = with pkgs; [
      lua-language-server
      stylua
      bash-language-server
      python3
      shfmt
      fnlfmt

      # forge's cli clients
      gh
      glab
      forgejo-cli

      qmk
    ];

    editorconfig = {
      enable = true;
      settings = {
        "*" = {
          end_of_line = "lf";
          insert_final_newline = true;
          trim_trailing_whitespace = true;
          charset = "utf-8";
          indent_size = 4;
          indent_style = "space";
        };
        "Makefile" = {
          indent_style = "tab";
        };
        "*.{nix,lua}" = {
          indent_size = 2;
        };
      };
    };

    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "daniil@rozanov.info";
          name = "Daniil Rozanov";
        };
        gpg.program = "gpg2";
      };
      signing = {
        key = "BDC40DA523D2E73A";
        signByDefault = true;
      };
    };
  };
}
