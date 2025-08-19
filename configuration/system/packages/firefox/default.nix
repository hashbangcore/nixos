{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    languagePacks = ["es-CL"];
    #wrapperConfig = {};
    #preferencesStatus = "locked";
    #preferences = {};
    #policies = {};
    #autoConfigFiles = [];
    #autoConfig = "";

    nativeMessagingHosts = {
      packages = with pkgs; [
        #bukubrow
        #ff2mpv
        #firefoxpwa
        #fx-cast-bridge
        #gnome-shell-extension-gsconnect
        #tridactyl-native
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    addwater
    #buku
    #bukubrow
    #ff2mpv-go
    #firefoxpwa
    #fx-cast-bridge
    #open-in-mpv
    #tridactyl-native
  ];
}
