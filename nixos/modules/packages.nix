{
  config,
  pkgs,
  pkgsUnstable,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Basic
    mkpasswd

    gnutar
    unzip

    binutils
    coreutils-full
    findutils
    binutils

    dmidecode # BIOS read tool.
    lshw
    pciutils
    usbutils
    xorg.xev # For keyboard key press properties.
    xorg.xkbcomp # For checking xkb keyboard symbol tables.

    libGL
    libGLU

    mlocate
    ncurses5

    fd
    tree
    file
    fzf

    wget
    curl
    openvpn

    btop
    killall
    ripgrep

    zsh
    bash

    # Virtualisation
    docker
    docker-compose
    libguestfs # Needed to virt-sparsify qcow2 files
    libvirt
    spice # For automatic window resize if this conf is used as OS in VM
    spice-vdagent
    virt-manager
  ];
}
