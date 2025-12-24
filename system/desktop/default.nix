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
      gdm = {
        wayland = true;
        enable = true;
        autoSuspend = false;
      };
    };
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
        options = "compose:rctrl";
      };
      videoDrivers = [ "intel" ];
    };
  };
}
