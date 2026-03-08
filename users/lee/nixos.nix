{ ... }: {
  users.users.lee = {
    isNormalUser = true;
    description = "lee";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lee = import ./home-manager.nix;
}
