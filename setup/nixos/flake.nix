{
  nixConfig = {
    
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixos-24.05/nixexprs.tar.xz";

    home-manager = {
      url = "github.nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    impermanence.url = "github:nix-community/impermanence";

    nur.url = "github:nix-community/nur";

    # an experimental Nushell environment for Nix.
    nuenv.url = "github:DeterminateSystems/nuenv";
  };

  outputs = {
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  }@inputs : 
    let
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                uesGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = inputs;
                users = {
                  ntwd = import ./ntwd;
                };
              };
            };
          ];
        };
      };
    };
}