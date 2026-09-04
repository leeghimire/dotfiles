{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
  programs.fish.enable = true;

  users.users.lee = {
    description = "Lee Ghimire";
    home = if isDarwin then "/Users/lee" else "/home/lee";
    shell = pkgs.fish;
  }
  // lib.optionalAttrs isLinux {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.lee = ./home.nix;
  };
}
