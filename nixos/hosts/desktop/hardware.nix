{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    hardware.nvidia.open = false;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.powerManagement.enable = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
