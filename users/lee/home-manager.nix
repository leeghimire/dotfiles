{ lib, pkgs, ... }:
let
  requestedPackageNames = [
    "git"
    "go"
    "gopls"
    "jq"
    "lua"
    "lua-language-server"
    "neovim"
    "pyright"
    "python3"
    "ripgrep"
    "stow"
    "tmux"
    "vtsls"
    "zig"
    "zls"
  ];

  requestedPackages = builtins.concatMap
    (name: lib.optional (builtins.hasAttr name pkgs) (builtins.getAttr name pkgs))
    requestedPackageNames;

  availablePackages = builtins.filter
    (pkg: lib.meta.availableOn pkgs.stdenv.hostPlatform pkg)
    requestedPackages;

  copyCommand =
    if pkgs.stdenv.isDarwin then
      "pbcopy"
    else
      "xclip -in -selection clipboard";
in {
  programs.home-manager.enable = true;

  home.username = "lee";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/lee" else "/home/lee";
  home.stateVersion = "25.05";

  home.sessionVariables =
    { TERMINAL = "ghostty"; }
    // lib.optionalAttrs pkgs.stdenv.isLinux { NIXOS_OZONE_WL = "1"; };

  home.file.".config/nvim".source = ./nvim;

  home.packages =
    availablePackages
    ++ [
      (pkgs.runCommand "vim-shadow" { } ''
        mkdir -p $out/bin
        ln -s ${pkgs.neovim}/bin/nvim $out/bin/vim
      '')
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [ pkgs.xclip ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Lee Ghimire";
      user.email = "hello@leeghimire.com";
      core.editor = "vim";
      init.defaultBranch = "main";
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -ga terminal-overrides ",screen-256color*:Tc"
      set-option -g default-terminal "screen-256color"
      set -s escape-time 0
      set -g repeat-time 0

      set-option -g status-style bg=default

      set -g base-index 1

      set-window-option -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel '${copyCommand}'

      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R
    '';
  };
}
