{
  config,
  lib,
  pkgs,
  ...
}:
{

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sr_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e91ea696-cdf3-4ae7-936c-c232efd7852b";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9CC5-9BD1";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/fa3c1963-50bc-4049-a59a-5115ebd0ecba";
    fsType = "xfs";
    options = [
      "noatime"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/3b9959aa-11a9-4e50-aa46-a8dbfb2be742";
    fsType = "xfs";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/9c42c8b5-78cc-4b1d-84af-475fc2b380f0";
    fsType = "xfs";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/flatpak" = {
    device = "/dev/disk/by-uuid/a4268f53-1341-477f-b380-b5f5550085d9";
    fsType = "btrfs";
    options = [
      "subvol=@apps"
      "compress=zstd:3"
      "noatime"
      "space_cache=v2"
    ];
  };

  fileSystems."/home/hash/.var" = {
    device = "/dev/disk/by-uuid/a4268f53-1341-477f-b380-b5f5550085d9";
    fsType = "btrfs";
    options = [
      "subvol=@data"
      "compress=zstd:3"
      "noatime"
      "space_cache=v2"
    ];
  };

  fileSystems."/pkgs/node" = {
    device = "/dev/disk/by-uuid/a4268f53-1341-477f-b380-b5f5550085d9";
    fsType = "btrfs";
    options = [
      "subvol=@node"
      "compress=zstd:3"
      "noatime"
      "space_cache=v2"
    ];
  };

  fileSystems."/pkgs/python" = {
    device = "/dev/disk/by-uuid/a4268f53-1341-477f-b380-b5f5550085d9";
    fsType = "btrfs";
    options = [
      "subvol=@python"
      "compress=zstd:3"
      "noatime"
      "space_cache=v2"
    ];
  };


  fileSystems."/home/hash/work" = {
    device = "/dev/disk/by-uuid/029271f6-c0a3-4af8-8f6b-2c5f00842690";
    fsType = "btrfs";
    options = [
      "subvol=@work"
      "compress=zstd:3"
      "noatime"
      "space_cache=v2"
    ];
  };

  fileSystems."/home/hash/multimedia" = {
    device = "/dev/disk/by-uuid/029271f6-c0a3-4af8-8f6b-2c5f00842690";
    fsType = "btrfs";
    options = [
      "subvol=@multimedia"
      "compress=zstd:3"
      "noatime"
      "space_cache=v2"
    ];
  };

  fileSystems."/home/hash/documents" = {
    device = "/dev/disk/by-uuid/029271f6-c0a3-4af8-8f6b-2c5f00842690";
    fsType = "btrfs";
    options = [
      "subvol=@documents"
      "compress=zstd:3"
      "noatime"
      "space_cache=v2"
    ];
  };

  fileSystems."/home/hash/secrets" = {
    device = "/dev/disk/by-uuid/029271f6-c0a3-4af8-8f6b-2c5f00842690";
    fsType = "btrfs";
    options = [
      "subvol=@secrets"
      "compress=zstd:3"
      "noatime"
      "space_cache=v2"
    ];
  };
  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp8s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20u1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  #hardware.cpu.intel.updateMicrocode = true;
}
