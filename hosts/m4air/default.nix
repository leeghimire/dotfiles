{ ... }: {
  imports = [
    ../../modules/shared.nix
    ../../modules/darwin-settings.nix
  ];

  networking.hostName = "Lees-MacBook-Air";

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
      "tailscale-app"
      "zen"
      "zotero"
    ];
  };
}
