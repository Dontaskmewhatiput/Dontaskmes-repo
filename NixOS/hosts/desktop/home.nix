# /etc/nixos/home.nix
{ pkgs, ... }:

{
  imports = [
    ../../home/zen.nix
    ../../modules/neovim/neovim.nix
    ../../modules/shell/shell.nix
    ../../home/git.nix
    ../../home/game.nix
    ../../home/home-packages.nix
    ../../modules/terminal/kitty.nix
    ../../home/git.nix
    ../../modules/dev/ssh/ssh-targets.nix
  ];

  programs = {
    zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
      enablePrivateDesktopEntry = true;
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
    };
  };
  home.packages = with pkgs; [
    obsidian
  ];
  home.stateVersion = "26.05";
}

