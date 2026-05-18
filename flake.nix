{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      apple-silicon,
      home-manager,
      ...
    }@inputs:
    let
      system = "aarch64-linux";
      pkgs-stable = import nixpkgs-stable {
        inherit system;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
        };
        modules = [ ./configuration.nix ];
      };
      homeConfigurations.chell = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit pkgs-stable;
        };
        modules = [ ./home.nix ];
      };
      # home-manager.useGlobalPkgs = true;
      # home-manager.useUserPackages = true;
    };
}
