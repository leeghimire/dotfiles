{
  description = "rags and thatch";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    zen-browser,
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

      nixosConfigurations."rhyolite" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/rhyolite
          ./users/lee/nixos.nix
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = "25.05";
            home-manager.extraSpecialArgs = { inherit zen-browser; };
            home-manager.users.lee = { imports = [ ./users/lee/rhyolite.nix ]; };
          }
        ];
      };
    };
}
