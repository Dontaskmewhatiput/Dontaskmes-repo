{ ... }: {
  services.openssh = {
    enable = true;
    ports = [ 2500 ];
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "Marco" ];
      X11Forwarding = false;
      MaxAuthTries = 3;
      LoginGraceTime = 20;
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
    };
  };
  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 2500 ];
  users.users.Marco.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPhg0cutukl1cqj4YubsvuoLXfI/x1m9t7ETO4MCmadC"
  ];
}
