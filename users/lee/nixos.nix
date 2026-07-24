{ pkgs, ... }: {
  programs.fish.enable = true;

  users.users.lee = {
    isNormalUser = true;
    description = "lee";
    extraGroups = [ "dialout" "docker" "networkmanager" "wheel" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = import ./authorized-keys.nix;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lee = import ./home-manager.nix;
}
