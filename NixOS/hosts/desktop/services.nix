{ ... }:
{
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    tailscale = {
      enable = true;
    };
    zram-generator = {
      enable = true;
      settings.zram0 = {
        host-memory-limit = 32768;
        zram-size = "min(ram / 2, 16384)";
        compression-algorithm = "zstd";
        swap-priority = 250;
        fs-type = "swap";
      };
    };
    flatpak.enable = true;
  };
}
