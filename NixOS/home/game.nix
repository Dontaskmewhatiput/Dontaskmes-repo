{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    steam
    inputs.twintaillauncher.packages.${pkgs.stdenv.hostPlatform.system}.default
    protonup-qt
    heroic
    protontricks
    protonplus
  ];
}
