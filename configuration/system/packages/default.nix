{
  pkgs,
  config,
  lib,
  ...
}:
let
  essentials = with pkgs; [
    alacritty
    cmus
    tmux
    trash-cli
    vis
  ];


  formatter = with pkgs; [
    alejandra
    dprint
    nixfmt-rfc-style
    shfmt
  ];
  utilities = with pkgs; [
    #bat
    #bind
    #dotacat
    #fping
    #iw
    #lexido
    #libva-utils
    #md-tui
    #mkcert
    #papeer
    #pciutils
    #pdftk
    #tdrop
    #wmctrl
    #xdotool
    btrfs-progs
    cava
    ccrypt
    compsize
    coreutils-full
    ffmpeg-full
    file
    fzf
    gocryptfs
    lsof
    mdcat
    mpv
    nmap
    pwgen
    sptlrx
    tealdeer
    translate-shell
    tree
    unp
    wget
    wl-clipboard
    yt-dlp
  ];

  libraries = with pkgs; [
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_CL
  ];

  development = with pkgs; [
    gnumake
    jq
    just
    parallel
    shellcheck
    watchexec
    zola
  ];

in
{
  imports = [
    ./scripts
    ./avahi
    ./shells
    ./buku
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
    ./tmux
    ./unbound
    ./unclutter
    ./vivid
  ];

  environment.systemPackages = builtins.concatLists [
    development
    essentials
    formatter
    libraries
    utilities
  ];

}
