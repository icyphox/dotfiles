{
  description = "icy's nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prompt = {
      url = "git+https://git.peppe.rs/cli/prompt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-snapshotter = {
      url = "github:pdtpartners/nix-snapshotter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-master
    , nixos-hardware
    , nix-snapshotter
    , nix-your-shell
    , home-manager
    , prompt
    , darwin
    , ...
    } @ inputs: {

      overlays = {
        prompt = prompt.overlay;
      };

      darwinConfigurations = {
        syl = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            {
              imports = [ ./hosts/syl/configuration.nix ];
              _module.args.self = self;
            }
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.icy = {
                imports = [ ./darwin/home.nix ];
                _module.args.self = self;
                _module.args.host = "syl";
                _module.args.inputs = inputs;
              };
            }
          ];
        };

        kvothe = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            {
              imports = [ ./hosts/kvothe/configuration.nix ];
              _module.args.self = self;
            }
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.icy = {
                imports = [ ./darwin/home.nix ];
                _module.args.self = self;
                _module.args.host = "kvothe";
                _module.args.inputs = inputs;
              };
            }
          ];
        };
      };

      nixosConfigurations = {
        wyndle = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              imports = [ ./hosts/wyndle/configuration.nix ];
              _module.args.self = self;
              nixpkgs.overlays = [ nix-your-shell.overlays.default ];
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.icy = {
                imports = [ ./home.nix ];
                _module.args.self = self;
                _module.args.host = "wyndle";
                _module.args.inputs = inputs;
              };
            }
          ];
        };
      };

      nixosConfigurations = {
        sini = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ config = { nix.registry.nixpkgs.flake = nixpkgs; }; })
            ({ config, pkgs, ... }: {
              services.pixelfed.package = nixpkgs-master.legacyPackages."x86_64-linux".pixelfed;
            })
            # ({ pkgs, ... }: {
            #   imports = [ nix-snapshotter.nixosModules.default ];
            #   nixpkgs.overlays = [ nix-snapshotter.overlays.default ];
            # })
            {
              imports = [ ./hosts/sini/configuration.nix ];
              _module.args.self = self;
            }
          ];
        };
      };
    };

}
