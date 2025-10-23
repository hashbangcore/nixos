{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      advanced-scene-switcher
      droidcam-obs
      obs-gstreamer
      obs-pipewire-audio-capture
      obs-webkitgtk
    ];
  };
}
