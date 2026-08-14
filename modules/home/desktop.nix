{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.desktop.enable = lib.mkEnableOption "Enable desktop environment";

  config = lib.mkIf config.desktop.enable {
    home.packages = with pkgs; [
      firefox
      librewolf
      chromium
      thunar
      calibre
      telegram-desktop
      imv
      mpv
      playerctl
      img
      keepassxc
      thunderbird
      plantuml # move to somewhere
      pavucontrol
      localsend
      zathura
      transmission_4-gtk
      euphonica
      gimp
      darktable
      mpc
      pinentry-all
      gnupg
      w3m
      vlc

      # cursor themes
      bibata-cursors

      # Rofi plugins
      rofimoji
      rofi-power-menu
      rofi-calc
      rofi-file-browser

      # Editors
      neovide
      emacs-pgtk

      # WM
      hyprshot
      libnotify
      wl-clipboard
      mako # or dunst
      rofi
      awww
      waybar
      grimblast
      hyprpolkitagent # may be outdated soon
      hyprpaper
      hypridle
      hyprlock
      hyprcursor
    ];

    programs.htop = {
      enable = true;
      settings = {
        tree_view = 1;
      };
    };

    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = -1;
        background_opacity = 0.8;
      };
    };

    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 20;
    };

    services.udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
      };
    };

    services.mako = {
      enable = true;
    };

    services.mpd = {
      enable = true;
    };

    services.mpdris2 = {
      enable = true;
    };

    services.ssh-agent.enable = true;

    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
    };

    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };

    gtk = {
      enable = true;
      colorScheme = "dark";
      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 20;
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      theme = {
        package = pkgs.orchis-theme;
        name = "Orchis-Dark";
      };
      gtk3.extraConfig = {
        "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
      };
      gtk4.extraConfig = {
        Settings = ''
          gtk-cursor-theme-name=Bibata-Modern-Classic
        '';
      };
    };

    home.file.".config/hypr".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/hypr";
    home.file.".config/waybar".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/waybar";
    home.file.".config/mako".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/mako";
    home.file.".config/rofi".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/rofi";
    home.file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/nvim";
    home.file.".config/mpd".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/mpd";

    wayland.windowManager.hyprland.systemd.enable = false;
  };
}
