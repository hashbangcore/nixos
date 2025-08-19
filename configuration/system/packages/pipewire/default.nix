{ pkgs, ... }:

{
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    easyeffects
    #helvum
    #coppwr
    #sonusmix
    #playerctl
  ];
}
