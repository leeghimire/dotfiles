{ ... }: {
  system.stateVersion = 6;
  networking.hostName = "Lees-MacBook-Air";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
