{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./cli.nix
    ./desktop.nix
    ./dev.nix
  ];
  config = {
    desktop.enable = lib.mkDefault true;
    development.enable = lib.mkDefault true;

    home.stateVersion = "26.05";
  };
}
