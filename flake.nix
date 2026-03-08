{
  description = "rags and thatch";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  }:
    let
      lib = nixpkgs.lib;
    in {
      darwinConfigurations."m4air" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ./hosts/m4air
          ./users/lee/darwin.nix
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = 6;
          }
        ];
      };

      nixosConfigurations."shale" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/shale
          ./users/lee/nixos.nix
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = "25.05";
          }
        ];
      };
    };
}
