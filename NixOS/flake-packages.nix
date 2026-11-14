{ pkgs, inputs, ... }:
let 
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = [
    inputs.helium-flake.packages.${system}.default
    inputs.zen-browser.packages.${system}.default
    inputs.twintaillauncher.packages.${system}.default
  ];
}
