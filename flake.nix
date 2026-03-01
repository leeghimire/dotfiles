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
      darwinConfigurations."Lees-MacBook-Air" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./nix/modules/shared.nix
          ./nix/modules/darwin-translated.nix
          ./nix/hosts/macbook.nix
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = 6;
          }
        ];
      };

      nixosConfigurations."desktop" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nix/modules/shared.nix
          ./nix/hosts/desktop.nix
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = "25.05";
          }
        ];
      };
    };
}
