{ inputs, pkgs, lib, ... }:
{
  services.displayManager.defaultSession = "plasma";
  hardware.graphics.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kde-rounded-corners
    inputs.kwin-effects-better-blur-dx.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  services.printing.enable = false;
  programs.kde-pim.enable = false;

  # Drops Qt5 compatibility layers.
  services.desktopManager.plasma6.enableQt5Integration = false;

  # Remove the optional KDE apps. Add back one at a time.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    aurorae
    kinfocenter
    plasma-systemmonitor
    kio-admin
    knighttime
    kunifiedpush
    ktexteditor
    krdp
    plasma-keyboard
    qtvirtualkeyboard
    union
    konsole
    plasma-systemmonitor
    gwenview
    okular
    kate
    khelpcenter
    dolphin-plugins
    ark
    plasma-browser-integration
    ffmpegthumbs
    kwrited
    kontact
    merkuro
    discover
    ktnef
    qrca 
    akonadi-import-wizard
    drkonqi
    kinfocenter
    kmail
    elisa
    akonadiconsole
  ];
}
