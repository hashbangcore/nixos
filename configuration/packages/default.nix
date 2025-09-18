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
  ];

  utilities = with pkgs; [
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
    libraries
    utilities
  ];

}
