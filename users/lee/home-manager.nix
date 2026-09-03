{ lib, pkgs, ... }: {
  programs.home-manager.enable = true;

  home.username = "lee";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/lee" else "/home/lee";
  home.stateVersion = "25.05";

  home.sessionPath = [ "$HOME/.local/bin" ];
  home.sessionVariables.TERMINAL = "ghostty";

  home.file.".config/nvim".source = ./nvim;

  home.packages = with pkgs; [
    jq
    pi-coding-agent
    ripgrep
  ];

  programs.bash = {
    enable = true;
    shellAliases = lib.mkIf pkgs.stdenv.isLinux {
      open = "xdg-open";
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
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
      color.ui = true;
      core.editor = "vim";
      init.defaultBranch = "main";
      user.email = "hello@leeghimire.com";
      user.name = "Lee Ghimire";
    };
  };

  programs.tmux.enable = true;
}
