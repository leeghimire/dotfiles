{
  description = "the geothermal larp going strong";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
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
          ./users/lee/home-manager.nix
          ./hosts/m4air
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit zen-browser; };
              users.lee.imports = [ ./users/lee/zen.nix ];
            };
          }
        ];
      };

      nixosConfigurations."rhyolite" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./users/lee/home-manager.nix
          ./modules/plasma.nix
          ./modules/virtualization.nix
          ./modules/ssh.nix
          ./hosts/rhyolite
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit zen-browser; };
              users.lee.imports = [
                ./users/lee/zen.nix
                ./users/lee/rhyolite.nix
              ];
            };
          }
        ];
      };

      nixosConfigurations."silica" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./users/lee/home-manager.nix
          # ./modules/plasma.nix
          # ./modules/virtualization.nix
          ./modules/ssh.nix
          ./hosts/silica
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
        ];
      };
    };
}
