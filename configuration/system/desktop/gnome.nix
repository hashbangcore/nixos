{
  config,
  pkgs,
  ...
}:
{
  services.xserver.desktopManager = {
    gnome.enable = true;
  };

  environment.systemPackages =
    (with pkgs; [
      gnome-tweaks
      gnome-themes-extra
      refine
    ])
    ++ (with pkgs.gnomeExtensions; [
      clipboard-indicator
      copier
      dash-to-dock
      gsconnect
      pip-on-top
      places-status-indicator
      quake-terminal
      user-themes
    ]);

  environment.gnome.excludePackages = with pkgs; [
    #baobab
    #decibels
    epiphany
    #evince
    #file-roller
    geary
    #gnome-calculator
    #gnome-calendar
    #gnome-characters
    #gnome-clocks
    #gnome-connections
    #gnome-console
    #gnome-contacts
    #gnome-disk-utility
    #gnome-font-viewer
    #gnome-logs
    #gnome-maps
    gnome-music
    gnome-software
    #gnome-system-monitor
    #gnome-text-editor
    gnome-tour
    gnome-weather
    #loupe
    #nautilus
    #seahorse
    simple-scan
    #snapshot
    #sushi
    totem
    yelp
  ];

}
