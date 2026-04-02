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
    "opencode"
    "pyright"
    "python3"
    "ripgrep"
    "stow"
    "tmux"
    "uv"
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

  linuxCopyCommand = pkgs.writeShellScript "tmux-copy-command" ''
    if command -v wl-copy >/dev/null 2>&1 && [ -n "''${WAYLAND_DISPLAY-}" ]; then
      exec wl-copy
    fi

    exec xclip -in -selection clipboard
  '';

  copyCommand =
    if pkgs.stdenv.isDarwin then
      "pbcopy"
    else
      "${linuxCopyCommand}";

  niriConfig = pkgs.runCommand "niri-config.kdl" { } ''
    cp ${pkgs.niri.doc}/share/doc/niri/default-config.kdl $out

    substituteInPlace $out \
      --replace-fail 'spawn-at-startup "waybar"' '// spawn-at-startup "waybar"' \
      --replace-fail 'Mod+T hotkey-overlay-title="Open a Terminal: alacritty" { spawn "alacritty"; }' 'Mod+T hotkey-overlay-title="Open a Terminal: ghostty" { spawn "ghostty"; }' \
      --replace-fail 'Mod+D hotkey-overlay-title="Run an Application: fuzzel" { spawn "fuzzel"; }' 'Mod+D hotkey-overlay-title="Run an Application: fuzzel" { spawn "fuzzel"; }'
  '';
in {
  programs.home-manager.enable = true;

  home.username = "lee";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/lee" else "/home/lee";
  home.stateVersion = "25.05";

  home.sessionVariables =
    { TERMINAL = "ghostty"; }
    // lib.optionalAttrs pkgs.stdenv.isLinux { NIXOS_OZONE_WL = "1"; };

  home.file.".config/nvim".source = ./nvim;
  xdg.configFile = lib.mkIf pkgs.stdenv.isLinux {
    "niri/config.kdl".source = niriConfig;
  };

  systemd.user.services = lib.mkIf pkgs.stdenv.isLinux {
    xwayland-satellite = {
      Unit = {
        Description = "Xwayland outside your Wayland compositor";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };
      Service = {
        ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
        Restart = "on-failure";
        RestartSec = 1;
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };

  home.packages =
    availablePackages
    ++ [
      (pkgs.runCommand "vim-shadow" { } ''
        mkdir -p $out/bin
        ln -s ${pkgs.neovim}/bin/nvim $out/bin/vim
      '')
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [ pkgs.fuzzel pkgs.wl-clipboard pkgs.xclip pkgs.xwayland-satellite ];

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
