{ lib, options, ... }:
let
  has = lib.hasAttrByPath;
in {
  config = lib.mkMerge [
    (lib.mkIf (has [ "system" "primaryUser" ] options) {
      system.primaryUser = "lee";
    })

    {
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
          "tailscale"
          "zotero"
        ];
      };
    }
  ];
}
