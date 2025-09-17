{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./gnome
    ./sway
  ];
  services = {
    displayManager = {
      autoLogin.enable = false;
      autoLogin.user = "hash";
    };
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
        options = "compose:rctrl";
      };
      videoDrivers = [ "intel" ];
      displayManager = {
        gdm = {
          wayland = true;
          enable = true;
          autoSuspend = false;
        };
      };
    };
  };
}
