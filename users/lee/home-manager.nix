{ _class, lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
lib.mkMerge [
  {
    programs.fish.enable = true;

    users.users.lee = {
      description = "Lee Ghimire";
      home = if isDarwin then "/Users/lee" else "/home/lee";
      shell = pkgs.fish;
    };

    home-manager.users.lee = {
      programs.home-manager.enable = true;

      home.stateVersion = "25.05";

      home.sessionPath = [ "$HOME/.local/bin" ];
      home.sessionVariables = {
        LC_TIME = "en_DK.UTF-8";
        TERMINAL = "ghostty";
      } // lib.optionalAttrs isLinux {
        LC_MEASUREMENT = "en_DK.UTF-8";
        LC_PAPER = "en_DK.UTF-8";
      };

      home.file.".config/nvim".source = ./nvim;

      home.packages = with pkgs; [
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

  (lib.optionalAttrs (_class == "darwin") {
    system.primaryUser = "lee";
  })

  (lib.optionalAttrs (_class == "nixos") {
    users.users.lee = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  })
]
