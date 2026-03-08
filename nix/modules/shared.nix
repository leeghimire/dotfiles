{ lib, options, ... }:
let
  has = lib.hasAttrByPath;
in {
  config = lib.mkMerge [
    (lib.mkIf (has [ "nix" "settings" ] options) {
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
    })

    (lib.mkIf (has [ "nix" "optimise" "automatic" ] options) {
      nix.optimise.automatic = true;
    })

  ];
}
