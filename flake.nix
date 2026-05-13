{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    apple-silicon.url = "github:nix-community/nixos-apple-silicon";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      apple-silicon,
      home-manager,
      ...
    }@inputs:
    let
      system = "aarch64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
        };
        modules = [ ./configuration.nix ];
      };
      homeConfigurations.chell = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };
        modules = [ ./home.nix ];
      };
      # home-manager.useGlobalPkgs = true;
      # home-manager.useUserPackages = true;
    };
}
