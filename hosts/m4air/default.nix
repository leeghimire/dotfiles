{ ... }: {
  networking.hostName = "Lees-MacBook-Air";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = 6;
}
