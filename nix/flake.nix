{
  description = "icy's nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim.url = "github:nix-community/neovim-nightly-overlay";

    prompt = {
      url = "path:/home/icy/code/nerd-prompt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , neovim
    , prompt
    , ...
    } @ inputs: {

      overlays = {
        nvim-nightly = neovim.overlay;
        prompt = prompt.overlay;
      };

      nixosConfigurations = {
        lapis = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              imports = [ ./hosts/lapis/configuration.nix ];
              _module.args.self = self;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.icy = {
                imports = [ ./home.nix ];
                _module.args.self = self;
                _module.args.inputs = inputs;
                _module.args.theme = import ./theme.nix;
              };
            }
          ];
        };
      };
    };

}
