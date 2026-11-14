{ pkgs, inputs, ... }:

{
  # Use https://search.nixos.org/ to find more packages and options
  environment.systemPackages = with pkgs; [
    neovim  
    wget
    git
    gnumake
    proton-vpn
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
  ];
}
