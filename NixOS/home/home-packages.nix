{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    bitwarden-desktop
    gnumake
    bitwarden-desktop
    yazi
    tmux 
    fastfetch
    btop
    libreoffice-qt
    proton-pass
    google-chrome
  ];
}
