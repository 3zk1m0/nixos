{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    ags.url = "github:Aylur/ags";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      yoga = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/yoga/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      xps = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/xps/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.nixos-hardware.nixosModules.dell-xps-15-9510-nvidia
        ];
      };
    };
  };
}
