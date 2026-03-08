{ ... }: {
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
}
