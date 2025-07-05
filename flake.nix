{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      lanzaboote,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "ricardo";

      overlays = [ (import ./overlays/gnome.nix) ];

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = overlays;
      };

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        overlays = overlays;
      };

      homeModule = {
        home-manager.useGlobalPkgs = true;
        home-manager.extraSpecialArgs = { inherit unstable; };
        home-manager.users.${username} = import ./home;
      };
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./system/hosts/laptop
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            homeModule
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./system/hosts/desktop
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            homeModule
          ];
        };
      };
    };
}
