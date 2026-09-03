{
  description = "rags and thatch";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
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
        ];
      };

      nixosConfigurations."rhyolite" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/rhyolite
          ./users/lee/nixos.nix
          { home-manager.extraSpecialArgs = { inherit zen-browser; }; }
        ];
      };
    };
}
