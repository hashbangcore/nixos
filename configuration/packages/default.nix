{
  pkgs,
  config,
  lib,
  ...
}:
let
  essentials = with pkgs; [
    alacritty
    tmux
    vis
  ];

  formatter = with pkgs; [
    alejandra
    dprint
    nixfmt-rfc-style
    shfmt
  ];
  utilities = with pkgs; [
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

in
{
  imports = [
    ./scripts
    ./avahi
    ./buku
    ./flatpak
    ./git
    ./gnupg
    ./logind
    ./neovim
    ./ollama
    ./openssh
    ./pass
    ./pipewire
    ./shells
    ./tmux
    ./unbound
    ./unclutter
    ./vivid
  ];

  environment.systemPackages = builtins.concatLists [
    essentials
    formatter
    libraries
    utilities
  ];

}
