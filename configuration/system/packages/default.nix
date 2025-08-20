{
  pkgs,
  config,
  lib,
  ...
}:
let
  essentials = with pkgs; [
    cmus
    vis
    just
    tmux
    alacritty
    tree
  ];

  graphical =
    (
      with pkgs;
      [
        #gnome-screenshot
        #blackbox-terminal
        authenticator
        planify
        rnote
        gimp3-with-plugins
        emulsion-palette
        paleta
        amberol
        #pencil
        #keypunch
        fractal
        varia
        warp
        #obs-studio
        gradia
        pitivi
        avidemux
        ascii-draw
        #gapless
        vaults
        parabolic
        video-trimmer
        eloquent
        iplookup-gtk
        footage
        webfontkitgenerator
        apostrophe
        buffer
        newsflash
        cozy
        dino
        dynamic-wallpaper
        foliate
        fragments
        gnome-decoder
        gnome-podcasts
        gnome-tweaks
        resources
        sly
        showtime
        packet
        iotas
        komikku
        monophony
        mousai
        multiplex
        paper-plane
        shortwave
        #tangram
        #celluloid
        carburetor
        dconf-editor
      ]
      ++ [ mpv ]
    )
    ++ (with pkgs.mpvScripts; [
      mpris
    ]);

  utilities =
    (with pkgs; [
      shfmt
      lexido
      dotacat
      md-tui
      papeer
      #llama-cpp
      cava
      sptlrx
      tdrop
      shellcheck
      #abduco
      tealdeer
      wmctrl
      xdotool
      #aria2
      fping
      gocryptfs
      mkcert
      bat
      bind
      ffmpeg-full
      fzf
      iw
      libva-utils
      gnumake
      mdcat
      #mesa-demos
      pciutils
      pdftk
      #pfetch-rs
      pwgen
      translate-shell
      unp
      wget
      #xclip
      yt-dlp
      #nap
      #ytcc
      #codesnap
    ]);

  games = with pkgs; [
    # superTux
    # superTuxKart
    #gnome-chess
    openmw
    #stockfish
    #zeroad
    #adwsteamgtk
    #cartridges
    #veloren
  ];

  extensions = with pkgs.gnomeExtensions; [
    pip-on-top
    #ddterm
    gsconnect
    dash-to-dock
    places-status-indicator
    #gtk4-desktop-icons-ng-ding
    clipboard-indicator
    copier
    #tiling-shell
  ];

  documentation = with pkgs; [
    biblioteca
  ];

  libraries = with pkgs; [
    #gtk4
    #libadwaita
    #libinput
    gnome-themes-extra
  ];

  system =
    with pkgs;
    [
      vis
      tree
      trash-cli
      file
      coreutils-full
      jq
    ]
    ++ [
      hunspell
      hunspellDicts.en_US
      hunspellDicts.es_CL
    ];

  development =
    (
      with pkgs;
      [
        elastic
        gnome-builder
        cambalache
      ]
      ++ [
        zola
        alejandra
        #devenv
        #direnv
        flatpak-builder
        #gcc
        #git
        #gomplate
        #meson
        #ninja
        #nix-direnv
        nixfmt-rfc-style
        #nixfmt-tree
        parallel
        #poetry
        watchexec
        #yarn
      ]
    )
    ++ (with pkgs.python312Packages; [
      #ipython
      python
      #bpython
    ]);

  playground = with pkgs; [
    #audacity
    #bashSnippets
    #bottes
    #celeste
    #chromium
    #citations
    #citations
    #curtail
    #denaro
    #dialect
    #pods
    drawing
    #drive
    #dynamic-wallpaper
    #escambo
    eyedropper
    forge-sparks
    dissent
    #ffsubsync
    #flatpak-builder
    #gnome-boxes
    #gnome-extension-manager
    gnome-frog
    #gnome-obfuscate
    #gnome-solanum
    #gnome-sound-recorder
    #gnome.gnome-boxes
    #hplip
    #hypnotix
    #imaginer
    #ipp-usb
    #junction
    #lbry
    #libreoffice-fresh
    #obs-studio
    #paleta
    #pika-backup
    #pinta
    #polari
    #portfolio-filemanager
    #qutebrowser
    #raider
    #soundconverter
    #speedtest
    #spot
    #tagger
    #turtle
    #warp
  ];
  pentesting = with pkgs; [
    #distrobox
    nmap
    #routersploit
    #metasploit
    #sqlmap
    #bettercap
    #aircrack-ng
    #airgorah
    #macchanger
    #armitage
  ];
  bloatware = with pkgs; [
    #eog
    epiphany
    evince
    gnome-console
    #gnome-contacts
    #gnome-disk-utility
    #gnome-photos
    gnome-system-monitor
    decibels
    #file-roller
    geary
    gnome-calculator
    #gnome-characters
    gnome-clocks
    #gnome-font-viewer
    #gnome-logs
    gnome-maps
    gnome-music
    #gnome-text-editor
    gnome-tour
    gnome-weather
    simple-scan
    #snapshot
    totem
    yelp
  ];
in
{
  imports = [
    ./scripts

    ./avahi
    ./bash
    #./buku
    ./firefox
    #./firejail
    ./flatpak
    ./git
    ./gnupg
    ./logind
    ./neovim
    ./ollama
    ./openssh
    ./pass
    ./pipewire
    #./thunderbird
    ./tmux
    ./unbound
    ./unclutter
    ./vivid
  ];

  environment.gnome.excludePackages = bloatware;
  environment.systemPackages = builtins.concatLists [
    #system
    #libraries
    essentials
    #pentesting
  ];
  users.users."hash".packages = builtins.concatLists [
    #graphical
    #utilities
    #documentation
    #development
    #games
    #playground
    extensions
  ];

}
