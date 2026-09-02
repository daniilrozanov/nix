{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./bluetooth.nix
  ];

  config = {
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = false;

      binfmt.emulatedSystems = [ "x86_64-linux" ];

      # The only thing that prevents greeter screen from corruption
      # Force a "quiet" boot sequence and strictly clamp the system log levels
      kernelParams = [
        "quiet"
        "loglevel=3"
        "systemd.show_status=auto"
        "rd.udev.log_level=3"
      ];
      # Suppress late-stage kernel alerts (like ACPI errors) from printing over the console
      kernel.sysctl = {
        "kernel.printk" = "3 3 3 3";
      };
    };

    users.users.chell = {
      isNormalUser = true;
      shell = pkgs.bash;
      extraGroups = [
        "wheel"
        "input"
        "networkmanager"
      ];
    };

    services.v2raya = {
      enable = true;
      cliPackage = pkgs.xray;
    };

    # Automount usb devices
    services.udisks2.enable = true;

    # Power management
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;

    environment.systemPackages = with pkgs; [
      fastfetch
      tree
      htop
      tmux
      unzip
      vim
      wget
      killall

      keyd # maybe move

      brightnessctl

      exfatprogs
      ntfs3g
      btrfs-progs

      home-manager
    ];

    fonts.packages = with pkgs; [
      dina-font
      fira-code
      fira-code-symbols
      liberation_ttf
      nerd-fonts.droid-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];

    programs.hyprland = {
      # wayland.windowManager.hyprland.systemd.enable = false;
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland.desktop'";
          user = "greeter";
        };
      };
    };
    # Bug: systemd logs corrupt greet screen, Code below DOES NOT fixes it
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYPath = "/dev/tty1";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    services.openssh.enable = true;

    networking.firewall.enable = false;

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Samara";

    i18n.defaultLocale = "en_US.UTF-8";

    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    nix = {
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      optimise = {
        automatic = true;
        dates = [ "weekly" ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 21d";
      };

    };

    system.stateVersion = "25.11";
  };
}
