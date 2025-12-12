{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./desktop
    ./filesystem
    ./packages
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    tmp = {
      useTmpfs = true;
      tmpfsSize = "2G";
      cleanOnBoot = true;
    };

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
    };
  };

  zramSwap.enable = true;

  security.rtkit.enable = true;

  time.timeZone = "America/Santiago";
  i18n = {
    defaultLocale = "es_CL.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_CL.UTF-8";
      LC_IDENTIFICATION = "es_CL.UTF-8";
      LC_MEASUREMENT = "es_CL.UTF-8";
      LC_MONETARY = "es_CL.UTF-8";
      LC_NAME = "es_CL.UTF-8";
      LC_NUMERIC = "es_CL.UTF-8";
      LC_PAPER = "es_CL.UTF-8";
      LC_TELEPHONE = "es_CL.UTF-8";
      LC_TIME = "es_CL.UTF-8";
    };
  };

  users.users."hash" = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "lp"
      "scanner"
      "audio"
      "video"
      "pipewire"
      "unbound"
    ];
  };

  networking = {
    hostName = "master";
    networkmanager.enable = true;
    networkmanager.dns = "none";
    firewall.enable = false;
  };

  system.stateVersion = "23.05";
}
