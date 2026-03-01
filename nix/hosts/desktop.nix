{ lib, options, ... }:
let
  has = lib.hasAttrByPath;
in {
  config = lib.mkIf (has [ "networking" "hostName" ] options) {
    networking.hostName = "desktop";
  };
}
