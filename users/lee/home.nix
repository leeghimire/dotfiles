{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  imports = [
    inputs.nix-index-database.homeModules.default
    ./zen.nix
  ];

  home.stateVersion = "25.05";

  home.packages =
    (with pkgs; [
      btop
      cloc
      codex
      curl
      devenv
      gh
      jq
      nixd
      ripgrep
      tree
    ])
    ++ lib.optionals isLinux [ pkgs.claude-code ];

  home.sessionPath = [ "$HOME/.local/bin" ];
  home.sessionVariables = {
    LC_TIME = "en_DK.UTF-8";
    TERMINAL = "ghostty";
  }
  // lib.optionalAttrs isLinux {
    LC_MEASUREMENT = "en_DK.UTF-8";
    LC_PAPER = "en_DK.UTF-8";
  };

  xdg.configFile."nvim".source = ./nvim;

  programs.home-manager.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.starship.enable = true;
  programs.tmux.enable = true;
  programs.zoxide.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = lib.mkIf isLinux {
      open = "xdg-open";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      color.ui = true;
      init.defaultBranch = "main";
      user.email = "hello@leeghimire.com";
      user.name = "Lee Ghimire";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;
  };

  # Use the smaller binaries-only database; the module defaults to the full one.
  programs.nix-index.package =
    inputs.nix-index-database.packages.${pkgs.stdenv.hostPlatform.system}.nix-index-with-small-db;
}
