# /etc/nixos/modules/shell.nix
{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "viins";
    enableCompletion = false;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = lib.mkMerge [
      # zsh-autocomplete has no enable option. It must load before compinit.
      (lib.mkOrder 550 ''
        source ${pkgs.zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
      '')
      (lib.mkOrder 750 ''
        source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
      '')
      (lib.mkOrder 800 ''
        for f in ${config.xdg.configHome}/zsh/conf.d/*.zsh; do source "$f"; done
      '')
    ];
  };

  xdg.configFile."zsh/conf.d" = {
    source = ./zsh;
    recursive = true;
  };

  xdg.configFile."starship.toml".source = ./zsh/starship.toml;

  home.packages = with pkgs; [ 
    starship 
    fzf 
    zoxide 
    eza 
    bat 
    ];
}
