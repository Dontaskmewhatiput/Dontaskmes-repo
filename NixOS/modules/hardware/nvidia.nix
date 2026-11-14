{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    branch = "bleeding_edge";
  };
  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
    nvtopPackages.nvidia
    libva-utils
    vulkan-tools
    vdpauinfo
  ];
}
