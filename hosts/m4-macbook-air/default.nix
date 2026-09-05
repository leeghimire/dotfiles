{ ... }:
{
  imports = [ ../../modules/common.nix ];

  system.stateVersion = 6;

  networking.hostName = "m4-macbook-air";

  system.primaryUser = "lee";

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      show-recents = false;
      tilesize = 32;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      "com.apple.sound.beep.feedback" = 0;
    };
  };

  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      "anki"
      "claude-code"
      "ghostty"
      "little-snitch"
      "netnewswire"
      "zen"
    ];
    masApps = {
      "uBlock Origin Lite" = 6745342698;
      Xcode = 497799835;
    };
  };
}
