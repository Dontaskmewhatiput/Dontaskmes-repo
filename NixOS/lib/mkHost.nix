{ nixpkgs, inputs, ... }:
hostname:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs; };
  modules = [ 
    ../hosts/${hostname}
    inputs.home-manager.nixosModules.home-manager
    ../modules/nixos/home-manager.nix
  ];
}
