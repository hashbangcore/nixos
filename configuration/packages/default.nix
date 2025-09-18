{
  pkgs,
  config,
  lib,
  ...
}:
let
  essentials = with pkgs; [
    alacritty
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
  ];

}
