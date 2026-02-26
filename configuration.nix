# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./apple-silicon-support
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Samara";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Sound.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Remap keyboard events
  # It is system-wide cz I'm not even sure it can be in home-manager
  services.keyd = {
    enable = true;
    keyboards = {
      macbookKeyboard = {
        ids = [ "05ac:0342:38ab045b" ];
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

  services.v2raya = {
    enable = true;
    cliPackage = pkgs.xray;
  };

  # Automount usb devices
  services.udisks2.enable = true;

  # Bluetooth
  services.blueman.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chell = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
    ];
  };

  environment.systemPackages = with pkgs; [
    # CLI
    fastfetch
    tree
    htop
    playerctl
    git
    tmux
    unzip
    vim
    w3m
    wget
    killall
    gnupg
    jq

    # System
    bluez
    bluez-alsa
    bluez-tools
    brightnessctl
    wl-clipboard
    keyd
    libnotify

    # GUI essentials
    mako # or dunst
    rofi
    swww
    waybar
    grimblast
    hyprpolkitagent # may be outdated soon
    hyprpaper
    hypridle
    hyprlock
    hyprcursor

    # Default GUI apps
    firefox
    vlc
    kitty

    # Other
    home-manager
  ];

  fonts.packages = with pkgs; [
    dina-font
    fira-code
    fira-code-symbols
    liberation_ttf
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.hyprland = {
    # add to home config later
    # wayland.windowManager.hyprland.systemd.enable = false;
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.uwsm = {
    enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 21d";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List services that you want to enable:

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "25.11";

}
