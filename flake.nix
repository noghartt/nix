{
  description = "Flake nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs@{ darwin, nixpkgs-unstable, home-manager, ... }:
  let
    inherit (nixpkgs-unstable.lib.attrsets) attrValues;

    nixpkgsConfigs = {
      config.allowUnfree = true;
    };
  in
  {
    darwinConfigurations = rec {
      "machine" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfigs;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.noghartt = import ./home.nix;
          }
        ];
      };
    };
  };
}