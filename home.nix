{ config, pkgs, ... }:
{
  home = {
    username = "chell";
    homeDirectory = "/home/chell";
    stateVersion = "25.11";
    packages = with pkgs; [
      fastfetch
      htop
      firefox
      nnn
      nemo
      calibre
      telegram-desktop
      imv
      mpv
      img
      chromium
      hyprshot
      keepassxc
      thunderbird
      cloc
      jq
      ripgrep
      fzf
      plantuml
      direnv
      nix-direnv
      pavucontrol # is there something for pipewire?
      localsend
      zathura
      transmission_4-gtk
      euphonica # buggy mpd gui client, haven't found any better yet
      gimp

      # cursor themes
      volantes-cursors
      bibata-cursors

      # Rofi plugins
      rofimoji
      rofi-power-menu
      rofi-calc
      rofi-file-browser

      # Editors
      neovide
      emacs-pgtk

      # Development
      nixd
      nixfmt
      lua-language-server
      stylua
      bash-language-server
      clang-tools
      python3
      shfmt
      fnlfmt

      # This probably need to go to shell.nix
      gnumake
      # cmake
      # ninja
      # bear
      # valgrind
      # perf
    ];
  };

  home.shell.enableShellIntegration = true;
  home.shellAliases = {
    ll = "ls -lh";
    la = "ls -lah";
    v = "nvim";
    nis = "sudo nixos-rebuild switch --flake .";
    hms = "home-manager switch --flake .";
    md = "mkdir -p";
  };
  home.sessionVariables = {
    VISUAL = "neovide";
    EDITOR = "nvim";
    FCEDIT = "nvim";
  };

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

  programs = {
    bash = {
      enable = true;
      profileExtra = ''if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then exec uwsm start default; fi'';
    };
    zsh = {
      enable = true;
    };
    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        nvim-autopairs
        nvim-bqf
        luasnip
        friendly-snippets
        nvim-cmp
        cmp-buffer
        cmp-path
        # cmp-luasnip # ERROR no such package
        lspkind-nvim
        cmp-nvim-lsp
        oil-nvim
        todo-comments-nvim
        conform-nvim
        gitsigns-nvim
        lazydev-nvim
        leap-nvim
        lualine-nvim
        nvim-web-devicons
        mini-nvim
        substitute-nvim
        nvim-surround
        text-case-nvim
        toggleterm-nvim
        which-key-nvim
        plenary-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        diffview-nvim
        neogit
        nvim-treesitter-parsers.nix
        nvim-treesitter-parsers.c
        nvim-treesitter-parsers.cpp
        nvim-treesitter-parsers.bash
        nvim-treesitter-parsers.hyprlang
        # nvim-treesitter-parsers.llvm
        nvim-treesitter-parsers.asm
        nvim-treesitter-parsers.lua
        nvim-treesitter-parsers.luadoc
        nvim-treesitter-parsers.fennel
        nvim-treesitter-parsers.vim
        nvim-treesitter-parsers.vimdoc
        nvim-treesitter-parsers.diff
        nvim-treesitter-parsers.gitcommit
        nvim-treesitter-parsers.json
        nvim-treesitter-parsers.yaml
        nvim-treesitter-parsers.toml
        nvim-treesitter-parsers.xml
        nvim-treesitter-parsers.html
        nvim-treesitter-parsers.css
        nvim-treesitter-parsers.markdown
        nvim-treesitter-parsers.latex
        nvim-treesitter-parsers.make
        nvim-treesitter-parsers.cmake
        nvim-treesitter-parsers.meson
        nvim-treesitter-parsers.query
        nvim-treesitter-parsers.http
      ];
      extraPackages = with pkgs; [
        gcc
        cmake
        gnumake
      ];
    };
    git = {
      enable = true;
      settings = {
        user = {
          email = "daniil@rozanov.info";
          name = "Daniil Rozanov";
        };
      };
    };
    direnv = {
      enable = true;
      # enableShellIntegration makes deal
      # enableBashIntegration = true;
      # enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    htop = {
      enable = true;
      settings = {
        tree_view = 1;
      };
    };
    ncmpcpp = {
      enable = true;
      settings = {
        mpd_host = "localhost";
        mpd_port = "6600";
        mpd_music_dir = "\${XDG_MUSIC_DIR}";
      };
    };
  };

  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/chell/dotfiles/hypr";
  home.file.".config/waybar".source =
    config.lib.file.mkOutOfStoreSymlink "/home/chell/dotfiles/waybar";
  home.file.".config/mako".source = config.lib.file.mkOutOfStoreSymlink "/home/chell/dotfiles/mako";
  home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "/home/chell/dotfiles/rofi";
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/chell/dotfiles/nvim";
  home.file.".config/mpd".source = config.lib.file.mkOutOfStoreSymlink "/home/chell/dotfiles/mpd";

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

  services.gpg-agent.enable = true;

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  wayland.windowManager.hyprland.systemd.enable = false;
}
