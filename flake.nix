{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    apple-silicon.url = "github:nix-community/nixos-apple-silicon";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      apple-silicon,
      home-manager,
      ...
    }@inputs:
    let
      system = "aarch64-linux";
    in
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix ];
      };
      homeConfigurations.chell = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home.nix ];
      };
      # home-manager.useGlobalPkgs = true;
      # home-manager.useUserPackages = true;
    };
}
