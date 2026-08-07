{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.bluetooth.enable = lib.mkEnableOption "Enable Bluetooth";

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };

    services.blueman.enable = true;

    environment.systemPackages = with pkgs; [
      bluez
      bluez-alsa
      bluez-tools
    ];
  };

}
