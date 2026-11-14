{ ... }:
{
  nixpkgs.hostPlatform = {
    system = "x86_64-linux";
    gcc.arch = "znver5";
    gcc.tune = "znver5";
  };
}
