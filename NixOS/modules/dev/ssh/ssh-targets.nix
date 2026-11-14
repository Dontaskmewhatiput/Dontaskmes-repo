{ ... }: 
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "github.com" = {
        IdentityFile = "~/.ssh/id_github";
        IdentitiesOnly = "yes";
        AddKeysToAgent = "yes";
      };

      Hex = {
        HostName = "Hex";
        User = "Marco";
        Port = "2500";
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = "yes";
      };

      network-adblock = {
        HostName = "network-adblock";
        User = "administrator";
        Port = "2500";
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = "yes";
      };
    };
  };
}
