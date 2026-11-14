{ ... }:
{
  networking = {
    networkmanager.enable = true;
    modemmanager.enable = false;

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
      trustedInterfaces = [ "tailscale0" ];
    };
  };
  # Tailscale
  services.tailscale.enable = true;
}
