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

    loader = {
      grub = {
        enable = true;
        device = "nodev"; # The special value nodev means that a GRUB boot menu will be generated, but GRUB itself will not actually be installed. We use UEFI.
        useOSProber = false; # Do not detect other operating systems.
        efiSupport = true;
        enableCryptodisk = false;
        extraEntries = ''
          menuentry "Reboot" {
            reboot
          }
          menuentry "Poweroff" {
            halt
          }
        '';
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };

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
