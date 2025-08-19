{
  config,
  pkgs,
  ...
}:
{
  services = {
    displayManager = {
      autoLogin.enable = false;
      autoLogin.user = "hash";
    };
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
        options = "compose:rctrl";
      };
      enable = true;
      videoDrivers = [ "intel" ];
      desktopManager = {
        gnome.enable = true;
      };
      displayManager = {
        gdm = {
          wayland = true;
          enable = true;
          autoSuspend = false;
        };
      };
    };
  };

  programs.dconf.enable = true;

  services.power-profiles-daemon.enable = true;
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
}
