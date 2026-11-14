# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  imports = [ 
    ../desktop/hardware-configuration.nix
    ../../modules/nixos/users.nix
    ../../home/packages.nix
    ../../modules/kde.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/users.nix
    ../../modules/sshd.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/nixos/security.nix
    # ./compile.nix
    ./services.nix
  ];

  networking.hostName = "Hex";

  home-manager.users.Marco = import ./home.nix;

  nixpkgs.config = {
    allowUnfree = true;
  };

  boot = {
    kernelParams = [ 
      "zswap.enabled=0"
    ];
    kernel.sysctl = {
      "vm.swappiness" = 200;
      "vm.page-cluster" = 0;
    };
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    loader.timeout = 1;
    # kernelModules = [ "r8169" "igc" ];
  };

  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # services.libinput.enable = true;

   hardware.bluetooth = {
    enable = true;
  };
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  programs = {
    steam = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
    nix-ld = {
      enable = true;
    };
  };

  nix.settings = {
    max-jobs = "auto";
    cores = 0;
    experimental-features = [ "nix-command" "flakes" ];
    system-features = [
      "nixos-test"
      "benchmark"
      "big-parallel"
      "kvm"
      "gccarch-znver5"
    ];
  };

  # Don't change
   system.stateVersion = "26.05"; 
}

