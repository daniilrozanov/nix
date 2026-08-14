{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    fastfetch
    tree
    htop
    cloc
    jq
    ripgrep
    fzf
    nnn
    direnv
    nix-direnv
    bc
  ];
  home.shell.enableShellIntegration = true;
  home.shellAliases = {
    ls = "ls --color=auto";
    ll = "ls -lh --color=auto";
    la = "ls -lah --color=auto";
    v = "nvim";
    c = "clear";
    df = "df -h";
    du = "du -h";
    "cd.." = "cd ..";
    ".." = "cd ..";
    "..." = "cd ../..";
    md = "mkdir -pv";
    path = "echo -e \${PATH//:/\\\\n}";
    rm = "rm --preserve-root";
    origsh = "ssh localhost";
    tree = "tree -C";

    # TODO: this should be for nixos only
    nis = "sudo nixos-rebuild switch --flake .";
    hms = "home-manager switch --flake .";

  };
  home.sessionVariables = {
    VISUAL = "neovide";
    EDITOR = "nvim";
    FCEDIT = "nvim";
  };

  programs.bash = {
    enable = true;
    historyControl = [
      "ignoreboth"
      "erasedups"
    ];
    historySize = 10000;
    initExtra = ''
      if [ -f ~/.bashrc.local ]; then
          . ~/.bashrc.local
      fi
    '';
  };

  programs.zsh = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    sideloadInitLua = true;
    plugins = with pkgs.vimPlugins; [
      nvim-autopairs
      nvim-bqf
      luasnip
      friendly-snippets
      nvim-cmp
      cmp-buffer
      cmp-path
      # cmp_luasnip
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
      # text-case-nvim # Why is this has unfree license??
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
      nvim-treesitter-parsers.slang
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
      # formatters and stuff probably?
    ];
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/nvim";
}
