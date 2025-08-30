{
  config,
  pkgs,
  ...
}:
let
  gemini = ''env NODE_OPTIONS=--dns-result-order=ipv4first GEMINI_API_KEY="$(pass google/gemini)" /data/workspace/repositories/gemini-cli/bundle/gemini.js '';
in
{
  imports = [
    ./desktop
    ./filesystem
    ./packages
  ];

  environment = {
    shellAliases = {
      cp = "cp --reflink=auto";
      docs_commits = "mdt /data/library/documents/docs/convencional-commits.md";
      docs_semver = "mdt /data/library/documents/docs/semver.md";
      gemini-flash = ''${gemini} --model gemini-2.5-flash'';
      gemini-lite = ''${gemini} --model gemini-2.5-flash-lite'';
      gemini-pro = ''${gemini} --model gemini-2.5-pro'';
      l = "tree -L 1";
      ls = "LC_ALL=C ls --color=tty --indicator-style=slash";
      music = "just -f /data/workspace/environment/scripts/music/justfile";
      rm = "trash-put";
      theme = "just -f /data/workspace/environment/scripts/theme/justfile";
    };

    variables = {
      CDPATH = "/data";
    };
  };

  nix = {
    enable = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      libva
    ];
    extraPackages32 = with pkgs; [ vaapiIntel ];
  };

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
