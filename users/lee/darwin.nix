{ ... }: {
  system.primaryUser = "lee";
  users.users.lee.home = "/Users/lee";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lee = import ./home-manager.nix;
}
