{ pkgs, ... }:

{
  programs = {
    waybar = {
      enable = true;
    };
    sway = {
      enable = true;
      xwayland = {
        enable = true;
      };
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      extraPackages = with pkgs; [
        brightnessctl
        foot
        grim
        slurp
        swayidle
        swaylock
        tdrop
        wmenu
      ];
    };

  };
}
