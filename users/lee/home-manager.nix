{ lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  system = lib.optionalAttrs isDarwin {
    primaryUser = "lee";
  };

  programs.fish.enable = true;

  users.users.lee = {
    description = "Lee Ghimire";
    home = if isDarwin then "/Users/lee" else "/home/lee";
    shell = pkgs.fish;
  }
  // lib.optionalAttrs isLinux {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.lee = { nix-index-database, pkgs, ... }: {
    imports = [ nix-index-database.homeModules.default ];

    programs.home-manager.enable = true;

    programs.nix-index-database.comma.enable = true;
    programs.nix-index.package =
      nix-index-database.packages.${pkgs.stdenv.hostPlatform.system}.nix-index-with-small-db;

    home.stateVersion = "25.05";

    home.sessionPath = [ "$HOME/.local/bin" ];
    home.sessionVariables = {
      LC_TIME = "en_DK.UTF-8";
      TERMINAL = "ghostty";
    }
    // lib.optionalAttrs isLinux {
      LC_MEASUREMENT = "en_DK.UTF-8";
      LC_PAPER = "en_DK.UTF-8";
    };

    home.file.".config/nvim".source = ./nvim;

    home.packages = with pkgs; [
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
    ];

    programs.bash = {
      enable = true;
      shellAliases = lib.mkIf isLinux {
        open = "xdg-open";
      };
    };

    programs.neovim = {
      enable = true;
      vimAlias = true;
    };

    programs.fish = {
      enable = true;
      shellAliases = lib.mkIf isLinux {
        open = "xdg-open";
      };
    };

    programs.starship.enable = true;

    programs.zoxide.enable = true;

    programs.git = {
      enable = true;
      settings = {
        color.ui = true;
        core.editor = "vim";
        init.defaultBranch = "main";
        user.email = "hello@leeghimire.com";
        user.name = "Lee Ghimire";
      };
    };

    programs.tmux.enable = true;
  };
}
