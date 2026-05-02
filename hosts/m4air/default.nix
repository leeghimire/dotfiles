{ ... }: {
  imports = [
    ../../modules/shared.nix
    ../../modules/darwin-settings.nix
    ../../modules/homebrew.nix
  ];

  networking.hostName = "Lees-MacBook-Air";
}
