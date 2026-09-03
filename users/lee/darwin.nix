{ ... }: {
  system.primaryUser = "lee";
  users.users.lee.home = "/Users/lee";

  system.defaults.dock = {
    autohide = true;
    autohide-delay = 0.0;
    show-recents = false;
    tilesize = 32;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    FXDefaultSearchScope = "SCcf";
    FXPreferredViewStyle = "Nlsv";
    ShowPathbar = true;
    ShowStatusBar = true;
  };

  system.defaults.NSGlobalDomain = {
    AppleShowAllExtensions = true;
    InitialKeyRepeat = 10;
    KeyRepeat = 1;
    "com.apple.sound.beep.feedback" = 0;
  };

  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    masApps = {
      "Xcode" = 497799835;
    };
    casks = [
      "anki"
      "claude-code"
      "codex"
      "ghostty"
      "little-snitch"
      "netnewswire"
      "zen"
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lee = import ./home-manager.nix;
}
