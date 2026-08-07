{
  config,
  pkgs,
  inputs,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
    "${inputs.apple-silicon}/apple-silicon-support"
  ];

  config = {
    bluetooth.enable = true;

    networking.hostName = "moon";

    networking.networkmanager.wifi.backend = "iwd";

    networking.wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };

    services.keyd = {
      enable = true;
      keyboards = {
        macbookKeyboard = {
          ids = [ "05ac:0342:89b7fedc" ];
          settings = {
            main = {
              capslock = "overload(control, esc)";
              # Test-driving these options below
              # shift = "oneshot(shift)";
              # meta = "oneshot(meta)";
              # control = "oneshot(control)";
              # leftalt = "oneshot(alt)";
              # rightalt = "oneshot(altgr)";
            };
          };
        };
      };
    };
    environment.etc."libinput/local-overrides.quirks".text = ''
      [Serial Keyboards]
      MatchUdevType=keyboard
      MatchName=keyd virtual keyboard
      AttrKeyboardIntegration=internal
    '';
  };
}
