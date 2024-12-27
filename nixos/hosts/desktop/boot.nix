{
  config,
  pkgs,
  ...
}:
{
  boot = {
    # Your `hardware-configuration.nix` should configure the LUKS device setup.
    # It should not be included here.

    # Enable all sysrq functions (useful to recover from some issues):
    # Documentation: https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html
    # Holding down Alt and SysRq (which is the Print Screen key) while slowly typing REISUB
    kernel.sysctl."kernel.sysrq" = 1; # NixOS default: 16 (only the sync command)

    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];

    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    ### Temp Files ==============================================================
    tmp.useTmpfs = true;
    tmp.cleanOnBoot = true;
    # ===========================================================================
  };
}
