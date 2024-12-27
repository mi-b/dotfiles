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
    hardware.nvidia.prime = {
      offload.enable = true;
      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:1:0:0";
    };
    hardware.nvidia.powerManagement.enable = true;
  };
}
