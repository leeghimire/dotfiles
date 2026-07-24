{ lib, pkgs, ... }:
let
  requestedPackageNames = [
    "bubblewrap"
    "claude-code"
    "go"
    "gopls"
    "jq"
    "lean4"
    "lua"
    "lua-language-server"
    "neovim"
    "pi-coding-agent"
    "pyright"
    "ripgrep"
    "uv"
    "vtsls"
    "zig"
    "zls"
    "rustc"
    "cargo"
    "rust-analyzer"
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
      "${pkgs.writeShellScript "tmux-copy-command" ''
        if command -v wl-copy >/dev/null 2>&1 && [ -n "''${WAYLAND_DISPLAY-}" ]; then
          exec wl-copy
        fi
        exec xclip -in -selection clipboard
      ''}";
in {
  programs.home-manager.enable = true;

  home.username = "lee";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/lee" else "/home/lee";
  home.stateVersion = "25.05";

  home.sessionPath = [ "$HOME/.local/bin" ];
  home.sessionVariables.TERMINAL = "ghostty";

  home.file.".config/nvim".source = ./nvim;

  home.packages =
    availablePackages
    ++ [
      (pkgs.runCommand "vim-shadow" { } ''
        mkdir -p $out/bin
        ln -s ${pkgs.neovim}/bin/nvim $out/bin/vim
      '')
    ];

  programs.bash = {
    enable = true;
    shellAliases = lib.mkIf pkgs.stdenv.isLinux {
      open = "xdg-open";
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = lib.mkIf pkgs.stdenv.isLinux {
      open = "xdg-open";
    };
  };

  programs.starship.enable = true;

  programs.zoxide.enable = true;

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
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      {
        plugin = continuum; # must load after resurrect
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '30'
        '';
      }
    ];
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
