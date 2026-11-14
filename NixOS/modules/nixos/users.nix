# modules/nixos/users.nix
{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  users.users.Marco = {
    isNormalUser = true;
    description = "Marco";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };
}
