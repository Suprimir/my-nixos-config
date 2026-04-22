{
  description = "Configuracion Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      spicetify-nix,
      nix-cachyos-kernel,
      apple-fonts,
      ...
    }@inputs:
    let
      mkHomeConfig = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.luis = import ./home.nix;
        home-manager.extraSpecialArgs = {
          inherit inputs;
          inherit spicetify-nix;
        };
        home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
      };
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            mkHomeConfig

            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  nix-cachyos-kernel.overlays.default
                  nix-cachyos-kernel.overlays.pinned
                ];
              }
            )
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/laptop/configuration.nix
            home-manager.nixosModules.home-manager
            mkHomeConfig

            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  nix-cachyos-kernel.overlays.default
                  nix-cachyos-kernel.overlays.pinned
                ];
              }
            )
          ];
        };
      };
    };
}
