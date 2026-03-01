{ ... }: {
  system.primaryUser = "lee";

  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    masApps = {
      "Things 3" = 904280696;
      "Vimari" = 1480933944;
      "Xcode" = 497799835;
      "uBlock Origin Lite" = 6745342698;
    };
    casks = [
      "anki"
      "claude-code"
      "codex"
      "ghostty"
      "little-snitch"
      "netnewswire"
      "proxyman"
      "signal"
      "zotero"
    ];
  };

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

  security.pam.services.sudo_local.touchIdAuth = true;
}
