{
  description = "rags and thatch";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, ... }:
    let
      lib = nixpkgs.lib;
    in {
      darwinConfigurations."m4air" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./nix/modules/shared.nix
          ./nix/modules/packages.nix
          ./nix/modules/darwin-settings.nix
          ./nix/modules/darwin-homebrew.nix
          ./nix/hosts/m4air.nix
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = 6;
          }
        ];
      };

      nixosConfigurations."shale" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nix/modules/shared.nix
          ./nix/modules/packages.nix
          ./nix/hosts/shale.nix
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = "25.05";
          }
        ];
      };
    };
}
